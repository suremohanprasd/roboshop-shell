script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

echo -e "\e[36m>>>>>>>>>> Copy Mongodb Repo <<<<<<<<<<\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[36m>>>>>>>>>> Install Mongod <<<<<<<<<<\e[0m"
yum install mongodb-org -y
echo -e "\e[36m>>>>>>>>>> Enable & Restart Mongod <<<<<<<<<<\e[0m"
systemctl enable mongod
systemctl start mongod
echo -e "\e[36m>>>>>>>>>> Change Localhost Address <<<<<<<<<<\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf
echo -e "\e[36m>>>>>>>>>> Restart Mongod <<<<<<<<<<\e[0m"
systemctl restart mongod