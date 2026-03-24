
resource "aws_iam_role" "this" {
    
    name = "${var.name}"

    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "${var.service}"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
