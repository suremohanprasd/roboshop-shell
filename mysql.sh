script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
mysql_root_password=$1

if [ -z "$mysql_root_password" ];
then
  echo Input MySQL Root Password Missing
  exit
fi

echo -e "\e[36m>>>>>>>>>> Disable MYSQL 8 Version <<<<<<<<<<\e[0m"
yum module disable mysql -y
echo -e "\e[36m>>>>>>>>>> Copy Mysql repos <<<<<<<<<<\e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo
echo -e "\e[36m>>>>>>>>>> Install mysql <<<<<<<<<<\e[0m"
yum install mysql-community-server -y
systemctl enable mysqld
systemctl start mysqld
echo -e "\e[36m>>>>>>>>>> Set Root Password <<<<<<<<<<\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1
mysql -uroot -pRoboShop@1