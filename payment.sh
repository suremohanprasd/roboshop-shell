script_path=$(dirname $0)
source ${script_path}/common.sh

echo -e "\e[36m>>>>>>>>>> Install python36 <<<<<<<<<<\e[0m"
yum install python36 gcc python3-devel -y
echo -e "\e[36m>>>>>>>>>> Add user Roboshop <<<<<<<<<<\e[0m"
useradd ${app_user}
rm -rf /app
mkdir /app
echo -e "\e[36m>>>>>>>>>> Download Application Code <<<<<<<<<<\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app
echo -e "\e[36m>>>>>>>>>> Unzip the file <<<<<<<<<<\e[0m"
unzip /tmp/payment.zip
echo -e "\e[36m>>>>>>>>>> Download Dependencies <<<<<<<<<<\e[0m"
cd /app
pip3.6 install -r requirements.txt
echo -e "\e[36m>>>>>>>>>> Set SystemD Payment Service  <<<<<<<<<<\e[0m"
cp ${script_path}/payment.service /etc/systemd/system/payment.service
systemctl daemon-reload
systemctl enable payment
systemctl start payment
