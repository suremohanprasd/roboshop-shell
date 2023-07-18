script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

echo -e "\e[36m>>>>>>>>>> Install Nginx <<<<<<<<<<\e[0m"
yum install nginx -y
echo -e "\e[36m>>>>>>>>>> Copying Roboshop Configuration <<<<<<<<<<\e[0m"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf
echo -e "\e[36m>>>>>>>>>> Removing content in web server <<<<<<<<<<\e[0m"
rm -rf /usr/share/nginx/html/*
echo -e "\e[36m>>>>>>>>>> Download the frontend content <<<<<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
echo -e "\e[36m>>>>>>>>>> Extract the frontend <<<<<<<<<<\e[0m"
cd /usr/share/nginx/html
echo -e "\e[36m>>>>>>>>>> Unzipping the file <<<<<<<<<<\e[0m"
unzip /tmp/frontend.zip
systemctl enable nginx
systemctl restart nginx
