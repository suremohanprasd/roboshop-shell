script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

component=user

func_nodejs

echo -e "\e[36m>>>>>>>>>> Copy mongod repo <<<<<<<<<<\e[0m"
cp ${script_path}/mongodb.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[36m>>>>>>>>>> Install Mongod <<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[36m>>>>>>>>>> Load Schema <<<<<<<<<<\e[0m"
mongo --host mongodb.mohanprasads.online </app/schema/user.js