output "content" {
  value = local.content

  description = "Generated unit file content."
}

output "checksum" {
  value = sha256(local.content)

  description = "Checksum of content."
}
