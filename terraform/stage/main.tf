provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}
module "vpc" {
  source           = "../modules/vpc"
  public_key_path  = var.public_key_path
  subnet_id        = var.subnet_id
  private_key_path = var.private_key_path
}
module "app" {
  source           = "../modules/app"
  public_key_path  = var.public_key_path
  app_disk_image   = var.app_disk_image
  subnet_id        = module.vpc.redit_subnet
  private_key_path = var.private_key_path
  db_ip            = module.db.external_ip_address_db
  # sec_group = module.vpc.group1
}
module "db" {
  source           = "../modules/db"
  public_key_path  = var.public_key_path
  db_disk_image    = var.db_disk_image
   subnet_id       = module.vpc.redit_subnet
  private_key_path = var.private_key_path
}
