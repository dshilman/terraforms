
variable "servers" {
  description = "Map of server types to configuration"
  type        = map(any)
  default = {
    server-iis = {
      #ami                    = "ami-056db1277deef2218"
      ver_os = "windows"
      instance_type          = "t2.micro",
      environment            = "dev"
   #   subnet_id              = "subnet-0ed4f00267a2f569f"
   #   vpc_security_group_ids = ["sg-055ae0bd4eabf5e0b"]
    },
    server-apache = {
      #ami                    = "ami-056db1277deef2218"
      ver_os = "ubuntu"
      instance_type          = "t2.nano",
      environment            = "test"
  #   subnet_id              = "subnet-0ed4f00267a2f569f"
   #   vpc_security_group_ids = ["sg-055ae0bd4eabf5e0b"]
    }
  }
}



resource "aws_instance" "web" {
  for_each               = var.servers 
  #ami                    = each.value.ami
    ami                    = (each.value.ver_os == "ubuntu") ? data.aws_ami.ubuntu.image_id : data.aws_ami.windows.image_id

  instance_type          = each.value.instance_type
  #subnet_id              = each.value.subnet_id
  #vpc_security_group_ids = each.value.vpc_security_group_ids

  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids

  tags = {
    "Identity"    = var.identity
    "Name"        = each.key
    "Environment" = each.value.environment
  }

}
resource "aws_instance" "web1" {

  #count = var.num_webs
  count = 0
  ami                    = (var.server_os == "ubuntu") ? data.aws_ami.ubuntu.image_id : data.aws_ami.windows.image_id
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids

 tags = {
    "Identity"    = var.identity
    "Name"        = "Student ${count.index + 1}/${var.num_webs}"
    "Environment" = "Training"
  }

}


output "public_dns" {
  description = "Public DNS names of the Servers"
  value = { for p in sort(keys(var.servers)) : p => aws_instance.web[p].public_dns }
}

output "public_ip" {
  description = "Public IP names of the Servers"
  value = { for p in sort(keys(var.servers)) : p => aws_instance.web[p].public_ip }
}

/*
output "public_ip" {
  value = aws_instance.web.*.public_ip
}

output "public_dns" {
  value = aws_instance.web.*.public_dns
}
*/