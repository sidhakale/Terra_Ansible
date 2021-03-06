resource "aws_instance" "web1" {
   ami           = "ami-0c2b8ca1dad447f8a"
   instance_type = "t2.micro"
   count = 1
  vpc_security_group_ids = ["sg-04167b4767dbd2890"]
   key_name               = "key-0cfa7d3e2d98a815e" 
   iam_instance_profile =   "EC2"
   user_data = <<-EOF
      #!/bin/bash     
      sudo amazon-linux-extras install ansible2 -y
      sudo yum install git -y
      sudo yum install maven -y      
      git -C ./home/ec2-user clone https://github.com/Abishek-Ravichander/Terra-Ansi-jFrog.git          
      cd /home/ec2-user/Terra-Ansi-jFrog && ansible-playbook main.yml -f 10
      cd /home/ec2-user/Terra-Ansi-jFrog && wget -O Java-Ansible.war https://abishek.jfrog.io/artifactory/abi_new/MyMavanWebapp/Java-Ansible/0.0.1-SNAPSHOT/Java-Ansible-0.0.1-SNAPSHOT.war
      cd /home/ec2-user/Terra-Ansi-jFrog && ansible-playbook deploy.yml -f 10
      EOF
   }
