echo -e "\e[36m>>>>>>>>>> Download NodeJS repos <<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[36m>>>>>>>>>> Install NodeJS <<<<<<<<<<\e[0m"
yum install nodejs -y
useradd roboshop
mkdir /app
echo -e "\e[36m>>>>>>>>>> Download Application Code <<<<<<<<<<\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
echo -e "\e[36m>>>>>>>>>> Unzip the file <<<<<<<<<<\e[0m"
unzip /tmp/user.zip
cd /app
echo -e "\e[36m>>>>>>>>>> Install npm <<<<<<<<<<\e[0m"
npm install
echo -e "\e[36m>>>>>>>>>> Copy user.service <<<<<<<<<<\e[0m"
cp user.service /etc/systemd/system/user.service
systemctl daemon-reload
systemctl enable user
systemctl start user
echo -e "\e[36m>>>>>>>>>> Copy mongod repo <<<<<<<<<<\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[36m>>>>>>>>>> Install Mongod <<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[36m>>>>>>>>>> Load Schema <<<<<<<<<<\e[0m"
mongo --host mongodb.mohanprasads.online </app/schema/user.js