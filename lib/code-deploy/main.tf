resource "aws_codedeploy_app" "app" {
  name = "${var.app_name}"
}

resource "aws_codedeploy_deployment_group" "stage_group" {
  app_name              = "${aws_codedeploy_app.app.name}"
  deployment_group_name = "${var.stage_deployment_group_name}"
  service_role_arn      = "${var.service_role}"

  autoscaling_groups = ["${var.stage_asg_list}"]

/*
  load_balancer_info {
    elb_info {
      name = "${var.stage_elb_name}"
    }
  }
*/

  deployment_style {
//    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }
  deployment_config_name = "CodeDeployDefault.OneAtATime"
}

resource "aws_codedeploy_deployment_group" "production_group" {
  app_name              = "${aws_codedeploy_app.app.name}"
  deployment_group_name = "${var.production_deployment_group_name}"
  service_role_arn      = "${var.service_role}"

  autoscaling_groups = ["${var.production_asg_list}"]

/*
  load_balancer_info {
    elb_info {
      name = "${var.production_elb_name}"
    }
  }
*/

  deployment_style {
//    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }
  deployment_config_name = "CodeDeployDefault.OneAtATime"
}


  //load_balancer_info {
  //  target_group_info {
  //    name = "demo-production-target-group"
  //  }
  //}

  //deployment_style {
  //  deployment_option = "WITH_TRAFFIC_CONTROL"
  //  deployment_type   = "BLUE_GREEN"
  //}
