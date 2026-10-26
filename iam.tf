resource "aws_iam_role" "morays_ha_role" {
    name = "morays-ha-role"
    assume_role_policy = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "morays_s3_policy" {
    name = "morays-s3-policy"
    role = aws_iam_role.morays_ha_role.id
    policy = <<EOF
   {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "morays_ha_instance_profile" {
    name = "morays-ha-instance-profile"
    role = aws_iam_role.morays_ha_role.name
}