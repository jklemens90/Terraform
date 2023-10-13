#create ELB and attach it to a target group consisting of the 2 web servers. Create a rule for the target group
#associate DNS records to the load balancer
#apply SSL cert to load balancer. Waiting for domain to transfer to AWS

resource "aws_elb" "web-server-elb" {
  name               = "web-server-elb"
  subnets            = [aws_subnet.public-us-east-1a.id, aws_subnet.public-us-east-1b.id]  
  
#In progress
#  access_logs {
   # bucket        = "example_bucket"
  #  bucket_prefix = "accesslogs"
 #   interval      = 60
#  }

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

#waiting for DNS registration to switch from cloudflare to aws
  #listener {
   # instance_port      = 8000
   # instance_protocol  = "http"
    #lb_port            = 443
    #lb_protocol        = "https"
    #ssl_certificate_id = "arn:aws:acm:us-east-1:046068811061:certificate/5901a785-c75f-45f4-a842-d6fc9ce9c1bb"
  #}

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = [aws_instance.web_server1.id, aws_instance.web_server2.id ]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "web-server-elb"
  }
}

#create internal application load balancer for app servers



