#!/bin/bash
#checking the environment
if [[ -e /etc/debian_version ]]; then
        ptoin=apt
elif [[ -e /etc/centos-release || -e /etc/redhat-release ]]; then
        ptoin=yum
else
        echo "Looks like you aren't running this installer on Debian, Ubuntu or CentOS"
        exit
fi

sudo $ptoin install software-properties-common -y
sudo $ptoin update -y && sudo $ptoin upgrade -y && sudo $ptoin clean

# Installing curl browser

if [[ -e /usr/bin/curl  ]]; then
  echo " ### Curl is Installed ### "
else 
  echo "###### Installing curl ######"
  sudo $ptoin install curl -y
fi

# Installing network tools
echo "###### Installing Net-Tools ######"
sudo $ptoin install net-tools -y
if [ $? == 0 ] ; then
  echo " #### nettool Installed Successfully #### "
else 
  echo " ### Net-Tool is not Installed ### "
  echo "2.Net-Tool is not Installed" >> Not_Installed.txt
 fi

# Installing htools app to view the ram and process digitally
echo "###### Installing htop ######"
sudo $ptoin install htop -y
if [ $? == 0 ] ; then
  echo " #### htop Installed Successfully #### "
else 
  echo " ### htop is not Installed ### "
  echo "3.htop is not Installed" >> Not_Installed.txt
 fi

# Installing python
sudo $ptoin update
echo "###### Installing Latest Python ######"
sudo $ptoint install python python-pip
if [ $? == 0 ] ; then
  echo " #### Latest Python Installed Successfully #### "
else 
  echo " ### Python is not Installed ### "
  echo "4.Python is not Installed" >> Not_Installed.txt
 fi

# Installing Ansible
echo "###### Installing Ansible ######"
sudo $ptoin install ansible
if [ $? == 0 ] ; then
  echo " #### Ansible Installed Successfully #### "
else 
  echo " ### Ansible is not Installed ### "
  echo "5.Ansible is not Installed" >> Not_Installed.txt
 fi

# Installing openssh-server
sudo $ptoin install openssh-server openssh-client -y

#to install apache server
sudo $ptoin install apache2 -y

# Installing skype
sudo wget https://go.skype.com/skypeforlinux-64.deb
sudo dpkg -i skypeforlinux-64.deb

# Installing java Default Version
sudo $ptoin install software-properties-common -y

sudo $ptoin install default-jdk -y && \
     $ptoin install default-jre -y
     
 # To Install Java Specific Version
 #sudo $ptoin install openjdk-8-jre-headless
 # Installing Maven
 sudo $ptoin install maven
 
 # Installing Tomcat
 sudo $ptoin install tomcat9

#Installing MySQL
sudo $ptoin install -y mysql-server mysql-client libmysqlclient-dev

#Installing PostgreSQL
sudo $ptoin update
sudo $ptoin install -y postgresql

#Installing Filezilla
sudo $ptoin install filezilla

# Installing elasticsearch
sudo $ptoin install elasticsearch

# Installing MongoDB
sudo $ptoin install mongodb

# Installing Node
sudo $ptoin install -y nodejs
sudo $ptoin install -y npm 

cd /opt/
wget -q https://dl.pstmn.io/download/latest/linux?arch=64 -O postman.tar.gz
sudo tar -xvzf postman.tar.gz
sudo rm postman.tar.gz
sudo ln -s /opt/Postman/Postman /usr/bin/postman
cat << EOT > postman.desktop
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Comment=Postman
Exec=postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
EOT
sudo mv postman.desktop /usr/share/applcations/


#to know the java path
#sudo update-alternatives --config java

#run below command to setup java_path
#nano /etc/environment

#paste below config for setup the java_path
#JAVA_HOME="usr/lib/jvm/jdk_path"
#nano ~/.bashrc
#paste below config in bashrc file
#export JAVA_HOME=/usr/lib/jvm/jdk_path
#export PATH=$JAVA_HOME/bin:$PATH

#run below command to configure the java_path
#source ~/.bashrc
#echo $JAVA_HOME

#sudo mkdir /opt/maven

#cd /opt/maven && \
   #wget http://mirrors.estointernet.in/apache/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz && \
   #tar -xvf apache-maven-3.6.0-bin.tar.gz && \
   #mv apache-maven-3.6.0/ apache-maven/

#run below command for setup maven path
#cd /etc/profile.d/
#cat << EOT > maven.sh
#paste below comfig for maven
# Apache Maven Environment Variables
# MAVEN_HOME for Maven 1 - M2_HOME for Maven 2
#export JAVA_HOME=/usr/lib/jvm/jdk_path
#export M2_HOME=/opt/maven/apache-maven
#export MAVEN_HOME=/opt/maven/apache-maven
#export PATH=${M2_HOME}/bin:${PATH}
#EOT

#run below command to configure the maven_path
#chmod +x maven.sh
#source maven.sh
#mvn -version

#sudo mkdir /opt/tomcat && \
     #cd /opt/tomcat/ && wget http://mirrors.estointernet.in/apache/tomcat/tomcat-9/v9.0.14/bin/apache-tomcat-9.0.14.tar.gz && \
     #tar -xvf apache-tomcat-9.0.14.tar.gz && mv  apache-tomcat-9.0.14/ tomcat9/

#granting execute permissions for all files in bin folder
#chmod +x /opt/tomcat/tomcat9/bin/*

#run below command to setup tomcat_path
#echo 'export CATALINA_HOME=/opt/tomcat/tomcat9' >> ~/.bashrc

#run below command to config the tomcat
#source ~/.bashrc
#echo $CATALINA_HOME
if [ $ptoin=apt ] then
    clear
         echo " Your Machine is Ubuntu"
             
sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io -y

docker --version
else [ $ptoin=yum ] then
clear
     echo "Your Machine is Centos"
     sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
      sudo yum install -y yum-utils \
      device-mapper-persistent-data \
      lvm2
      sudo yum-config-manager \
      --add-repo \
      https://download.docker.com/linux/centos/docker-ce.repo
      sudo yum install docker-ce docker-ce-cli containerd.io
      sudo systemctl start docker
      docker --version
fi
# kubernetes setup
#sudo $ptoin update && sudo $ptoin install -y $ptoin-transport-https && \
#curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo $ptoin-key add - && \
#echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list && \
#sudo $ptoin update && \
#sudo $ptoin install -y kubectl kubeadm kubelet
#echo kubectl version

#curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  #&& chmod +x minikube && \
  #sudo cp minikube /usr/local/bin && rm minikube
#echo minikube version

#Installing Ruby
#curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
#curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -#
#echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

#sudo $ptoin update
#sudo $ptoin install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn

#cd
#git clone https://github.com/rbenv/rbenv.git ~/.rbenv
#echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
#echo 'eval "$(rbenv init -)"' >> ~/.bashrc
#exec $SHELL

#git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
#echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
#exec $SHELL

#rbenv install 2.6.1
#rbenv global 2.6.1
#ruby -v

# Instaliing Zentyal server on linux machine
#curl -s download.zentyal.com/install | sudo sh

# to log in to the zentyal server we need to add user to admin group
#sudo usermod -a -G admin username

# Installing openvpn
sudo $ptoin install openvpn -y

# Installing gnome tweak tool which contains adanced options for ubuntu gui
sudo add-$ptoin-repository universe
sudo $ptoin install gnome-tweak-tool
# Download STS 
cd /opt/
sudo wget https://download.springsource.com/release/STS/3.9.9.RELEASE/dist/e4.12/spring-tool-suite-3.9.9.RELEASE-e4.12.0-linux-gtk-x86_64.tar.gz
sudo tar -xzvf spring-tool-suite-3.9.9.RELEASE-e4.12.0-linux-gtk-x86_64.tar.gz
cd /opt/sts-bundle/sts-3.9.9.RELEASE
cat << EOT > STS.desktop
[Desktop Entry]
Name=SpringSource Tool Suite
Comment=SpringSource Tool Suite
Exec=/opt/sts-bundle/sts-3.9.9.RELEASE/STS
Icon=/opt/sts-bundle/sts-3.9.9.RELEASE/icon.xpm
StartupNotify=true
Terminal=false
Type=Application
Categories=Development;IDE;Java;
EOT

sudo mv STS.desktop /usr/share/applications/

sleep 5

