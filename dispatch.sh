script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

echo -e "\e[36m>>>>>>>>>> Install golang <<<<<<<<<<\e[0m"
yum install golang -y
echo -e "\e[36m>>>>>>>>>> Add user Roboshop <<<<<<<<<<\e[0m"
useradd ${app_user}
rm -rf /app
mkdir /app
echo -e "\e[36m>>>>>>>>>> Download Application Code <<<<<<<<<<\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
cd /app
echo -e "\e[36m>>>>>>>>>> Unzip the File <<<<<<<<<<\e[0m"
unzip /tmp/dispatch.zip
echo -e "\e[36m>>>>>>>>>> Download the Dependencies and bulid the software <<<<<<<<<<\e[0m"
cd /app
go mod init dispatch
go get
go build
echo -e "\e[36m>>>>>>>>>> Set SystemD payment service <<<<<<<<<<\e[0m"
cp ${script_path}/dispatch.service /etc/systemd/system/dispatch.service
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch