script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

echo -e "\e[36m>>>>>>>>>> Setup Nodejs Repos <<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[36m>>>>>>>>>> Install Nodejs <<<<<<<<<<\e[0m"
yum install nodejs -y
echo -e "\e[36m>>>>>>>>>> Add user Roboshop <<<<<<<<<<\e[0m"
useradd ${app_user}
echo -e "\e[36m>>>>>>>>>> Let Setup an App Directory <<<<<<<<<<\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[36m>>>>>>>>>> Download Application Code <<<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
echo -e "\e[36m>>>>>>>>>> unzip the file <<<<<<<<<<\e[0m"
unzip /tmp/catalogue.zip
cd /app
echo -e "\e[36m>>>>>>>>>> Install npm <<<<<<<<<<\e[0m"
npm install
echo -e "\e[36m>>>>>>>>>> set SystemD Catalogue Service <<<<<<<<<<\e[0m"
cp ${script_path}/catalogue.service /etc/systemd/system/catalogue.service
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue
echo -e "\e[36m>>>>>>>>>> Copy mongodb repo file <<<<<<<<<<\e[0m"
cp ${script_path}/mongodb.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[36m>>>>>>>>>> Install Mongod <<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[36m>>>>>>>>>> Load Schema <<<<<<<<<<\e[0m"
mongo --host mongodb.mohanprasads.online </app/schema/catalogue.js