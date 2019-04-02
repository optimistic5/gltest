resource "aws_codedeploy_deployment_group" "test_app" {
  app_name              = "${aws_codedeploy_app.test_app.name}"
  deployment_group_name = "${var.deployment_group_name}"
  service_role_arn      = "${aws_iam_role.web_iam_role.arn}"

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Deploy"
      type  = "KEY_AND_VALUE"
      value = "yes"
    }
  }
}

resource "aws_codedeploy_app" "test_app" {
  compute_platform = "ECS"
  name             = "test_app"
}
