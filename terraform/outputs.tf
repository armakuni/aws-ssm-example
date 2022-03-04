output "private_box_instance_id" {
  value = aws_instance.private_box.id
}

output "unmanaged_box_instance_id" {
  value = aws_instance.unmanaged_box.id
}
