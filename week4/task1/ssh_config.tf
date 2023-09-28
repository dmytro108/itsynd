resource "local_file" "ssh_config" {
  content = templatefile("${var.ssh_config_template}",
    {
      hosts = concat(aws_instance.app_servers[*].private_ip, [aws_instance.db.private_ip])

    }
  )

  filename = var.ssh_config_file
}
