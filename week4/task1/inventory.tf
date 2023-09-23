resource "local_file" "AnsibleInventory" {
  content = templatefile("${var.inventory_template}",
    {
      app_servers = aws_instance.app_servers[*].private_ip,
      db_servers = [aws_instance.db.private_ip]
    }
  )

  filename = "${var.inventory_file}"
}
