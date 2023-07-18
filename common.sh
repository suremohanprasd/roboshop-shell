app_user=roboshop

print_head() {
  echo -e "\e[36m>>>>>>>>>> $1 <<<<<<<<<<\e[0m"
}

schema_setup() {
  echo -e "\e[36m>>>>>>>>>> Copy MongoDB repo <<<<<<<<<<\e[0m"
  cp ${script_path}/mongodb.repo /etc/yum.repos.d/mongo.repo
  echo -e "\e[36m>>>>>>>>>> Install MongoDB Client <<<<<<<<<<\e[0m"
  yum install mongodb-org-shell -y
  echo -e "\e[36m>>>>>>>>>> Load Schema <<<<<<<<<<\e[0m"
  mongo --host mongodb.mohanprasads.online </app/schema/${component}.js
}

func_nodejs() {
  print_head "Configuring NodeJS repos"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash
  print_head "Install NodeJs"
  yum install nodejs -y
  print_head "Add Application User"
  useradd ${app_user}
  print_head "Create Application Directory"
  rm -rf /app
  mkdir /app
  print_head "Download Application Content"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
  cd /app
  print_head "Unzip Application Content"
  unzip /tmp/${component}.zip
  print_head "Install NodeJs Dependencies"
  cd /app
  npm install
  print_head "Create Application Directory"
  cp ${script_path}/${component}.service /etc/systemd/system/${component}.service
  systemctl daemon-reload
  systemctl enable ${component}
  systemctl start ${component}

  schema_setup
}
