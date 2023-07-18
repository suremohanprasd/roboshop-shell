script_path=$(dirname $0)
source ${script_path}/common.sh

echo -e "\e[36m>>>>>>>>>> Install Repo file <<<<<<<<<<\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
yum module enable redis:remi-6.2 -y
echo -e "\e[36m>>>>>>>>>> Install Redis <<<<<<<<<<\e[0m"
yum install redis -y
systemctl enable redis
systemctl start redis
echo -e "\e[36m>>>>>>>>>> Change Localhost IPAdress <<<<<<<<<<\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis.conf
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis/redis.conf
systemctl restart redis