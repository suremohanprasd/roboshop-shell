script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

echo -e "\e[36m>>>>>>>>>> Install Maven <<<<<<<<<<\e[0m"
yum install maven -y
echo -e "\e[36m>>>>>>>>>> Add User Roboshop <<<<<<<<<<\e[0m"
useradd ${app_user}
rm -rf /app
mkdir /app
echo -e "\e[36m>>>>>>>>>> Download Application Code <<<<<<<<<<\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app
echo -e "\e[36m>>>>>>>>>> Unzipping the file <<<<<<<<<<\e[0m"
unzip /tmp/shipping.zip
echo -e "\e[36m>>>>>>>>>> Download the dependencies and bulid & Application <<<<<<<<<<\e[0m"
cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar
echo -e "\e[36m>>>>>>>>>> Set SystemD Shipping Service <<<<<<<<<<\e[0m"
cp ${script_path}/shipping.service /etc/systemd/system/shipping.service
systemctl daemon-reload
systemctl enable shipping
systemctl start shipping
echo -e "\e[36m>>>>>>>>>> Install mysql <<<<<<<<<<\e[0m"
yum install mysql -y
mysql -h mysql.mohanprasads.online -uroot -pRoboShop@1 < /app/schema/shipping.sql
systemctl restart shipping
