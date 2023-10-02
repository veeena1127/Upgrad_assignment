# Create a Null Resource and Provisioners
resource "null_resource" "Name" {
  depends_on = [module.ec2_public, module.ec2_jenkins, module.ec2_app]
  # Connect to Bastion Instance after it is created
  connection {
    type     = "ssh"
    host     = aws_eip.bastion_eip.public_ip    
    user     = "ubuntu"
    password = ""
    private_key = file("/Users/manavsheth/terraform-ansible-jenkins/private-key/upgrad_project.pem")
  }  


# Create ansible inventory file and SSH Config file for ProxyJump
  provisioner "local-exec" {
    command = <<-EOF
          sudo apt update
          sudo apt install ansible -y
          echo [jenkins] > ansible-playbook/inventory
          echo ${module.ec2_jenkins.private_ip}  >> ansible-playbook/inventory
          echo [app] >> ansible-playbook/inventory
          echo ${module.ec2_app.private_ip} >> ansible-playbook/inventory
          echo [bastion] >> ansible-playbook/inventory
          echo ${module.ec2_public.private_ip} >> ansible-playbook/inventory
         
          echo  "Host ${aws_eip.bastion_eip.public_ip}" > ansible-playbook/config
          echo  User ubuntu >> ansible-playbook/config
          echo  "Hostname ${aws_eip.bastion_eip.public_ip}" >> ansible-playbook/config
          echo   ProxyJump ubuntu@bastion >> ansible-playbook/config
          echo   IdentityFile ../private-key/upgrad-project.pem >> ansible-playbook/config
          echo   StrictHostKeyChecking no >> ansible-playbook/config

          echo  Host bastion >> ansible-playbook/config
          echo  User ubuntu >> ansible-playbook/config
          echo  "Hostname ${aws_eip.bastion_eip.public_ip}" >> ansible-playbook/config
          echo   IdentityFile ../private-key/upgrad-project.pem >> ansible-playbook/config
          echo   StrictHostKeyChecking no >> ansible-playbook/config

          echo   Host jenkins >> ansible-playbook/config
          echo   "HostName ${module.ec2_jenkins.private_ip}" >> ansible-playbook/config
          echo   User ubuntu >> ansible-playbook/config
          echo   IdentityFile ../private-key/upgrad-project.pem >> ansible-playbook/config
          echo   ProxyJump ubuntu@bastion >> ansible-playbook/config
          echo   StrictHostKeyChecking no >> ansible-playbook/config

          echo   "Host ${module.ec2_jenkins.private_ip}" >> ansible-playbook/config
          echo   "HostName ${module.ec2_jenkins.private_ip}" >> ansible-playbook/config
          echo   User ubuntu >> ansible-playbook/config
          echo   IdentityFile ../private-key/upgrad-project.pem >> ansible-playbook/config
          echo   ProxyJump ubuntu@bastion >> ansible-playbook/config
          echo   StrictHostKeyChecking no >> ansible-playbook/config

          echo   Host app >> ansible-playbook/config
          echo   "HostName ${module.ec2_app.private_ip}" >> ansible-playbook/config
          echo   User ubuntu >> ansible-playbook/config
          echo   IdentityFile ../private-key/upgrad-project.pem >> ansible-playbook/config
          echo   ProxyJump ubuntu@bastion >> ansible-playbook/config
          echo   StrictHostKeyChecking no >> ansible-playbook/config

          echo   "Host ${module.ec2_app.private_ip}" >> ansible-playbook/config
          echo   "HostName ${module.ec2_app.private_ip}" >> ansible-playbook/config
          echo   User ubuntu >> ansible-playbook/config
          echo   IdentityFile ../private-key/upgrad-project.pem >> ansible-playbook/config
          echo   ProxyJump ubuntu@bastion >> ansible-playbook/config
          echo   StrictHostKeyChecking no >> ansible-playbook/config
      EOF
  }
}
