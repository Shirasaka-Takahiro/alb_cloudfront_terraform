##Route53 Zone
#resource "aws_route53_zone" "primary_zone" {
#name = var.zone_name
#}

##Route53 Records
resource "aws_route53_record" "naked_domain" {
  #zone_id = aws_route53_zone.primary_zone.zone_id
  zone_id = "Z07403921OYE516WPU79B"
  #name    = var.zone_name
  name = "onya-lab.site"
  type = "A"
  alias {
    name                   = aws_cloudfront_distribution.cloudfront.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www" {
  #zone_id = aws_route53_zone.primary_zone.zone_id
  zone_id = "Z07403921OYE516WPU79B"
  #name    = "${var.sub_domain_1}.${var.zone_name}"
  name = "${var.sub_domain_1}.onya-lab.site"
  type = "A"
  alias {
    name                   = aws_cloudfront_distribution.cloudfront.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "loadbalancer" {
  #zone_id = aws_route53_zone.primary_zone.zone_id
  zone_id = "Z07403921OYE516WPU79B"
  #name    = "${var.sub_domain_2}.${var.zone_name}"
  name = "${var.sub_domain_2}.onya-lab.site"
  type = "A"
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}