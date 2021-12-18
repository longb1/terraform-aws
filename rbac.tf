#Identity Access to allow S3 access

#create role
resource "aws_iam_role" "longb_S3Role" {
  name = "longb_S3_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

#Create Policy (allow read only access S3 bucket)
resource "aws_iam_role_policy" "S3ReadPolicy" {
  name = "S3ReadPolicy"
  role = aws_iam_role.longb_S3Role.id #assign to role
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:Get*",
          "s3:List*",
          "s3-object-lambda:Get*",
          "s3-object-lambda:List*"
        ],
        "Resource" : "*"
      }
    ]
  })
}

#create profile to assign to ec2 instance
resource "aws_iam_instance_profile" "longb_ec2profile" {
  name = "longb_ec2profile"
  role = aws_iam_role.longb_S3Role.name
}