pip3 install ansible
ansible-galaxy install -r requirements.yml
ansible-playbook -i inventory.yml playbook.yml
