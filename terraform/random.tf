resource "random_id" "environment_id" {
  byte_length = 6
}

resource "random_id" "shared_config" {
  byte_length = 6
}
