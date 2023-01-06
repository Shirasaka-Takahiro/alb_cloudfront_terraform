##Cloudfront
resource "aws_cloudfront_distribution" "cloudfront" {
  enabled = true
  aliases = [
    #"${var.zone_name}"
    "onya-lab.site"
  ]

  origin {
    #domain_name = "${var.sub_domain_2}.${var.zone_name}"
    domain_name = "${var.sub_domain_2}.onya-lab.site"
    origin_id   = aws_lb.alb.id
    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "https-only"
      origin_read_timeout      = 60
      origin_ssl_protocols     = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
    custom_header {
      name  = "shira-header"
      value = "shira-header"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    #acm_certificate_arn            = aws_acm_certificate.cert_cloudfront.arn
    acm_certificate_arn      = aws_acm_certificate.cert_cloudfront.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  default_cache_behavior {
    allowed_methods  = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
    cached_methods   = ["HEAD", "GET", "OPTIONS"]
    target_origin_id = aws_lb.alb.id

    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
      headers = ["*"]
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 10
    max_ttl                = 60
  }

}