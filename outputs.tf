output "ip" {
    description = "The aws www-example ipv4 address"
    value = aws_instance.www-example.public_ip
    }