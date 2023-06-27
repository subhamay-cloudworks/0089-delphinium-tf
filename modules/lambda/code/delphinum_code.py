# -*- coding: utf-8 -*-
"""
Created on Wed Jue 24 21:39:01 2024

@author: Subhamay Bhattacharyya
"""

import json
import logging
import boto3
import os
import random


# Load the exceptions for error handling
from botocore.exceptions import ClientError, ParamValidationError
from boto3.dynamodb.types import TypeDeserializer, TypeSerializer

s3_client = boto3.client('s3', region_name=os.getenv('AWS_REGION'), config=boto3.session.Config(signature_version='s3v4',))
# Create a new SES resource and specify a region.
client = boto3.client('ses',region_name=os.getenv('AWS_REGION'))

s3_bucket_name = os.getenv('S3_BUCKET_NAME') 
s3_default_folder = os.getenv('S3_DEFAULT_FOLDER')
sender = os.getenv('SENDER')
recipient= os.getenv('RECIPIENT')
configuration_set = os.getenv('CONFIGURATION_SET')
charset= os.getenv('CHARSET')
subject = os.getenv('SUBJECT')

 

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def create_presigned_url(bucket_name, object_name, expiration=3600):
    """Generate a presigned URL to share an S3 object

    :param bucket_name: string
    :param object_name: string
    :param expiration: Time in seconds for the presigned URL to remain valid
    :return: Presigned URL as string. If error, returns None.
    """

    # Generate a presigned URL for the S3 object
    try:
        response = s3_client.generate_presigned_url('get_object',
                                                    Params={'Bucket': bucket_name,
                                                            'Key': object_name},
                                                    ExpiresIn=expiration)
    except ClientError as e:
        logging.error(e)
        return None

    # The response contains the presigned URL
    return response
    
def send_email_message(presigned_url):

    # The email body for recipients with non-HTML email clients.
    BODY_TEXT = ("Amazon SES Test (Python)\r\n"
                "This email was sent with Amazon SES using the "
                "AWS SDK for Python (Boto)."
                )
                
    # The HTML body of the email.
    BODY_HTML = f"""<html>
    <head></head>
    <body background='{presigned_url}'>
    <h1>Good Morning</h1>
    </body>
    </html>
                """   

    # Try to send the email.
    try:
        #Provide the contents of the email.
        response = client.send_email(
            Destination={
                'ToAddresses': [
                    recipient,
                ],
            },
            Message={
                'Body': {
                    'Html': {
                        'Charset': charset,
                        'Data': BODY_HTML,
                    },
                    'Text': {
                        'Charset': charset,
                        'Data': BODY_TEXT,
                    },
                },
                'Subject': {
                    'Charset': charset,
                    'Data': subject,
                },
            },
            Source=sender#,
            # If you are not using a configuration set, comment or delete the
            # following line
            #ConfigurationSetName=configuration_set,
        )
    # Display an error if something goes wrong.	
    except ClientError as e:
        print(e.response['Error']['Message'])
    else:
        print("Email sent! Message ID:"),
        print(response['MessageId'])

def lambda_handler(event, context):

    # logger.info(f"event :: {json.dumps(event)}")
    
    objects = s3_client.list_objects(Bucket=s3_bucket_name,Prefix=s3_default_folder)
    images = [object.get("Key") for object in objects["Contents"] if object.get("Key").endswith(".jpg") ]
    random_index = random.randint(0,len(images)-1) 
    logger.info(f"random_index = {random_index}")
    random_image = images[random.randint(0,len(images)-1) ]
    
    logger.info(f"random_index : {random_image}")
    
    presigned_url = create_presigned_url(s3_bucket_name,random_image,3600)
    logger.info(f"presigned URL : {presigned_url}")
    send_email_message(presigned_url)

    
    return {
        "statusCode":200,
        "Message": "Hello from Lambda !"
    }