#!/bin/bash


INTERNAL_IP=$(gcloud compute instances describe db --project=positive-rush-426912-h6 --format='get(networkInterfaces[0].networkIP)')

# Print the internal IP
echo "Internal IP: $INTERNAL_IP"
#
# # Use Ansible to update the MySQL configuration on the DB instance
ansible db -m lineinfile -a "path=/etc/mysql/mysql.conf.d/mysqld.cnf regexp='^bind-address\s*=\s*.*$' line='bind-address = $INTERNAL_IP'" -b
#
# # Use Ansible to restart the MySQL service on the DB instance
 ansible db -m service -a "name=mysql state=restarted" -b
