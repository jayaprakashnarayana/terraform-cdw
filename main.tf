terraform {
  required_providers {
    # docker = {
    #   source  = "kreuzwerker/docker"
    #   version = "2.21.0"
    # }

    aws = {
      source  = "hashicorp/aws"
      version = "4.30.0"
    }

  }
}

# provider "docker" {
#   # Configuration options
# }

provider "aws" {
  #configuration 
  region = "us-east-1"
  alias = "region_1"

}

provider "aws" {
  #configuration 
  region = "us-east-2"
  alias = "region_2"
}

data "aws_region" "region_1" {
  provider = aws.region_1
}

data "aws_region" "region_2" {
  provider = aws.region_2
}

# resource - resource - resource-name 

resource "aws_cloudwatch_dashboard" "main" {
  # name of the dashboard
  dashboard_name = "my-dashboard-test" 
  provider = aws.region_2
  
  dashboard_body = <<EOF
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "CPUUtilization",
            "InstanceId",
            "i-012345"
          ]
        ],
        "period": 300,
        "stat": "Average",
        "region": "us-east-1",
        "title": "EC2 Instance CPU"
      }
    },
    {
      "type": "text",
      "x": 0,
      "y": 7,
      "width": 3,
      "height": 3,
      "properties": {
        "markdown": "Hello world"
      }
    }
  ]
}
EOF
}