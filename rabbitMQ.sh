script_path=$(dirname $0)
source ${script_path}/common.sh

echo -e "\e[36m>>>>>>>>>> Configure YUM Repos from the script provided by vendor <<<<<<<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
echo -e "\e[36m>>>>>>>>>> Configure YUM Repos for RabbitMQ <<<<<<<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
echo -e "\e[36m>>>>>>>>>> Install RabbitMQ server <<<<<<<<<<\e[0m"
yum install rabbitmq-server -y
systemctl enable rabbitmq-server
systemctl start rabbitmq-server
echo -e "\e[36m>>>>>>>>>> Add user Roboshop <<<<<<<<<<\e[0m"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
