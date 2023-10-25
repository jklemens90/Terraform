/*
Use App stream to securely access servers in the private subnet.
 App stream acts a bastion host and an extra layer of defense
*/

/*
#image builder. Use image builder to create image with RDP application

resource "aws_appstream_image_builder" "App-stream-3tier-builder" {
  name                           = "App-stream-3tier-builder"
  description                    = "App-stream-3tier-builder"
  display_name                   = "App-stream-3tier-builder"
  enable_default_internet_access = true
  image_name                     = "AppStream-WinServer2019-06-12-2023"
  instance_type                  = "stream.standard.large"

  vpc_config {
    subnet_ids = [aws_subnet.public-us-east-1b.id]
  }

  tags = {
    Name = "App-stream-3tier-builder"
  }
}
*/




#create fleet with image that has RDP app. 
#Note: Fleet takes 10 minutes to create
#Consider provisioning fleet in its own VPC
resource "aws_appstream_fleet" "App-stream-3tier" {
  name = "App-stream-3tier"

  compute_capacity {
    desired_instances = 1
  }

  description                        = "App-stream-3tier"
  idle_disconnect_timeout_in_seconds = 600
  display_name                       = "App-stream-3tier"
  enable_default_internet_access     = false
  fleet_type                         = "ON_DEMAND"
  image_name                         = "RDP"
  instance_type                      = "stream.standard.large"
  max_user_duration_in_seconds       = 4000

  vpc_config {
    subnet_ids = [aws_subnet.private-us-east-1b.id]
  }

  tags = {
    TagName = "App-stream-3tier-fleet"
  }
}



#users
resource "aws_appstream_user" "John" {
  authentication_type = "USERPOOL"
  user_name           = "${var.ad-user-email}"
  first_name          = "${var.first-name}"
  last_name           = "${var.last-name}"
}


#user stack association
resource "aws_appstream_user_stack_association" "App-stream-3tier" {
  authentication_type = "USERPOOL"
  stack_name          = aws_appstream_stack.App-stream-3tier.name
  user_name           = "${var.ad-user-email}"
}




#stack
resource "aws_appstream_stack" "App-stream-3tier" {
  name         = "App-stream-3tier"
  description  = "App-stream-3tier"
  display_name = "App-stream-3tier"
  feedback_url = "http://johnklemens.com/feedback"
  redirect_url = "http://johnklemens.com/redirect"

  storage_connectors {
    connector_type = "HOMEFOLDERS"
  }

  user_settings {
    action     = "CLIPBOARD_COPY_FROM_LOCAL_DEVICE"
    permission = "ENABLED"
  }
  user_settings {
    action     = "CLIPBOARD_COPY_TO_LOCAL_DEVICE"
    permission = "ENABLED"
  }
  user_settings {
    action     = "DOMAIN_PASSWORD_SIGNIN"
    permission = "ENABLED"
  }
  user_settings {
    action     = "DOMAIN_SMART_CARD_SIGNIN"
    permission = "DISABLED"
  }
  user_settings {
    action     = "FILE_DOWNLOAD"
    permission = "ENABLED"
  }
  user_settings {
    action     = "FILE_UPLOAD"
    permission = "ENABLED"
  }
  user_settings {
    action     = "PRINTING_TO_LOCAL_DEVICE"
    permission = "ENABLED"
  }

  application_settings {
    enabled        = true
    settings_group = "SettingsGroup"
  }

  tags = {
    TagName = "App-stream-3tier-stack"
  }
}

#fleet stack association
resource "aws_appstream_fleet_stack_association" "App-stream-3tier-assoc" {
  fleet_name = aws_appstream_fleet.App-stream-3tier.name
  stack_name = aws_appstream_stack.App-stream-3tier.name
}






/*

#Code to have Appstream join the directory
#Need to set up a service account before this block of code can work

#app stream directory config
resource "aws_appstream_directory_config" "Appstream-directory-config" {
  directory_name                          = "${var.dir_domain_name}"
  organizational_unit_distinguished_names = ["Appstream"]

#reference future creds in AWS Secrets Manager
  service_account_credentials {
    account_name     = "DOMAIN\username"
    account_password = "PASSWORD OF ACCOUNT"
  }
}

*/

