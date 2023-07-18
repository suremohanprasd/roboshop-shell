app_user=roboshop


func_nodejs() {
  echo -e "\e[36m>>>>>>>>>> Configuring NodeJS repos <<<<<<<<<<\e[0m"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash
  echo -e "\e[36m>>>>>>>>>> Install NodeJs <<<<<<<<<<\e[0m"
  yum install nodejs -y
  echo -e "\e[36m>>>>>>>>>> Add Application User <<<<<<<<<<\e[0m"
  useradd ${app_user}
  echo -e "\e[36m>>>>>>>>>> Create Application Directory <<<<<<<<<<\e[0m"
  rm -rf /app
  mkdir /app
  echo -e "\e[36m>>>>>>>>>> Download Application Content <<<<<<<<<<\e[0m"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
  cd /app
  echo -e "\e[36m>>>>>>>>>> Unzip Application Content <<<<<<<<<<\e[0m"
  unzip /tmp/${component}.zip
  echo -e "\e[36m>>>>>>>>>> Install NodeJs Dependencies <<<<<<<<<<\e[0m"
  cd /app
  npm install
  echo -e "\e[36m>>>>>>>>>> Create Application Directory <<<<<<<<<<\e[0m"
  cp ${script_path}/${component}.service /etc/systemd/system/${component}.service
  systemctl daemon-reload
  systemctl enable ${component}
  systemctl start ${component}
}
