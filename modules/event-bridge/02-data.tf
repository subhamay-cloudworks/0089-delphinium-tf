## ---------------------------------------------------------------------------------------------------------------------
## Data Definition - Event Bridge Module - Project Delphinum
## Modification History:
##   - 1.0.0    Jun 24,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

# AWS Region and Caller Identity
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}


