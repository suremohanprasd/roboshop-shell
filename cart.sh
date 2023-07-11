source common.sh

echo -e "\e[36m>>>>>>>>>> Setup NodeJS <<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[36m>>>>>>>>>> Install NodeJs <<<<<<<<<<\e[0m"
yum install nodejs -y
useradd ${app_user}
rm -rf /app
mkdir /app
echo -e "\e[36m>>>>>>>>>> Download Application Code <<<<<<<<<<\e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app
echo -e "\e[36m>>>>>>>>>> UnZipping the File <<<<<<<<<<\e[0m"
unzip /tmp/cart.zip
echo -e "\e[36m>>>>>>>>>> Download the Dependencies <<<<<<<<<<\e[0m"
cd /app
npm install
echo -e "\e[36m>>>>>>>>>> Set SystemD Cart Service <<<<<<<<<<\e[0m"
cp /home/centos/roboshop-shell/cart.service /etc/systemd/system/cart.service
systemctl daemon-reload
systemctl enable cart
systemctl start cart