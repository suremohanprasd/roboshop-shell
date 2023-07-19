app_user=roboshop

func_print_head() {
  echo -e "\e[36m>>>>>>>>>> $1 <<<<<<<<<<\e[0m"
}

func_schema_setup() {
  if [ "schema_setup" == "mongo" ]; then
  func_print_head "Copy MongoDB repo"
  cp ${script_path}/mongodb.repo /etc/yum.repos.d/mongo.repo

  func_print_head "Install MongoDB Client"
  yum install mongodb-org-shell -y

  func_print_head "Load Schema"
  mongo --host mongodb.mohanprasads.online </app/schema/${component}.js
  fi

  if ["schema_setup" == "mysql"]; then
    func_print_head "Install mysql client"
    yum install mysql -y

    func_print_head "Load Schema"
    mysql -h mysql.mohanprasads.online -uroot -p${mysql_root_password} < /app/schema/shipping.sql
}

func_app_prereq() {
  func_print_head "Create Application User"
  useradd ${app_user}
  func_print_head "Create Application Directory"
  rm -rf /app
  mkdir /app
  func_print_head "Download Application Content"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
  func_print_head "Extract Application Content"
  cd /app
  unzip /tmp/${component}.zip
}

func_systemd_setup() {
   func_print_head "Set SystemD Shipping Service"
   cp ${script_path}/${component}.service /etc/systemd/system/${component}.service
   func_print_head "Start ${component} Service"
   systemctl daemon-reload
   systemctl enable ${component}
   systemctl restart ${component}
}

func_nodejs() {
  func_print_head "Configuring NodeJS repos"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash

  func_print_head "Install NodeJs"
  yum install nodejs -y

  func_app_prereq

  func_print_head "Install NodeJs Dependencies"
  cd /app
  npm install

  func_schema_setup

  func_systemd_setup
}

func_java() {
  func_print_head "Install Maven"
  yum install maven -y

  func_app_prereq

  func_print_head "Download Maven dependencies"
  mvn clean package
  mv target/${component}-1.0.jar ${component}.jar

  func_schema_setup
  func_systemd_setup
}
