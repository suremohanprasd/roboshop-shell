curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
useradd roboshop
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip
cd /app
npm install
cp catalogue.sh /etc/systemd/system/catalogue.service
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue
cp mongodb.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y
mongo --host mondodb.mohanprasads.online </app/schema/catalogue.js