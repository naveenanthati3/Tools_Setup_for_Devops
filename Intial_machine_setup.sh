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
sleep 2

# Installing curl browser

if [[ -e /usr/bin/curl  ]]; then
  echo " ### Curl is Installed ### "
else 
  echo "###### Installing curl ######"
  sudo $ptoin install curl -y &> Not_Installed.txt
      if [[ $? == 0 ]]; then
       echo "##### Curl Successfully Installed #####"
      else
       echo " ### Curl is not Installed ### "
       echo "##### 1.Curl not Installed #####" &>> Not_Installed.txt
      fi
fi
sleep 2

# Installing network tools
if [[ -e  /var/lib/dpkg/info/net-tools.list ]]; then
echo " ###### Net-Tools Available ##### "
else
echo "###### Installing Net-Tools ######"
sudo $ptoin install net-tools -y &>> Not_Installed.txt
    if [ $? == 0 ] ; then
      echo " #### nettool Installed Successfully #### "
    else 
      echo " ### Net-Tool is not Installed ### "
      echo "2.Net-Tool is not Installed" >> Not_Installed.txt
    fi
fi
sleep 2

# Installing htools app to view the ram and process digitally

if [[ -e /usr/bin/htop ]]; then
echo " ##### Htop is Available ##### "
else
echo " ###### Installing htop ###### "
sudo $ptoin install htop -y &>> Not_Installed.txt
    if [ $? == 0 ] ; then
      echo " #### htop Installed Successfully #### "
    else 
      echo " ### htop is not Installed ### "
      echo "3.htop is not Installed" >> Not_Installed.txt
    fi
fi
sleep 2

# Installing python
sudo $ptoin update
PS3=" Enter options for Python Installation: "
select python in Available_Versions Install_Specific_Version Install_Python_pip Skip_Python_Installation
do 
  case $python in
  Available_Versions)
        echo "#######" "Available Python Versions are " $(ls /usr/local/lib |grep python) "########"
        ;;
  Install_Specific_Version)    
        echo -n "Enter Required Version of Python:"
        read n
        sudo $ptoin install -y python$n python3-pip &>> Not_Installed.txt
        if [ $? == 0 ] ; then
          echo " #### Python$n Installed Successfully #### "
        else 
          echo " ### Python is not Installed ### "
          echo "4.Python is not Installed" >> Not_Installed.txt
        fi
        ;;
  Install_Python_pip)
        echo " #### Installing Python_Pip #### "
        sudo $ptoin install -y python3-pip
        if [ $? == 0 ] ; then
          echo " #### Python-pip Installed Successfully #### "
        else 
          echo " ### Python-pip is not Installed ### "
          echo "4.Python-pip is not Installed" >> Not_Installed.txt
        fi
  Skip_Python_Installation)
        echo " #### Going to Next Installation #### "
          break
          ;;
  *)
        echo " Error: Please try again (select 1..4)!"
  esac
done
sleep 2

# Installing Ansible
if [[ -e /usr/bin/ansible ]]; then
echo "##### Ansible is Installed #####"
else
while :
do
clear
        echo " What do you want "
        echo "1)Install Ansible "
        echo "2)Skip Ansible"
        read -p "Select option [1-2] : " option
        case $option in
        1)
        echo "###### Installing Ansible ######"
        sudo $ptoin install ansible &>> Not_Installed.txt
        if [ $? == 0 ] ; then
                echo " #### Ansible Installed Successfully #### "
        else 
                echo " ### Ansible is not Installed ### "
                echo "5.Ansible is not Installed" >> Not_Installed.txt
        fi
        break
        ;;
        2)
        echo " Skipping Ansible "
        break
       esac
      done
fi
sleep 2

# Installing openssh-server
if [[ -e /etc/network/if-up.d/openssh-server ]]; then
echo " #### Open-ssh Server in Installed #### "
else
  echo " ##### Installing open-ssh server ##### "
  sudo $ptoin install openssh-server openssh-client -y &>> Not_Installed.txt
    if [[ $? == 0 ]]; then
      echo " ### openssh server installed successfully ### "
    else
      echo "6.Openssh Server is not installed" >> Not_Installed.txt
    fi
fi
sleep 2

#to install apache server
#if [[ -e /etc/apache2/apache2.conf ]]; then
#  echo " ##### Apache Server is Installed ##### "
#else
#  echo " #### Installing Apache Server #### "
 # sudo $ptoin install apache2 -y &>> Not_Installed.txt
  #if [[ $? == 0 ]]; then
   # echo " ### Apache Server is Installed Successfully ### "
  #else
   # echo " ### 7.Apache Server is not Installed ### " >> Not_Installed.txt
  #fi
#fi
#sleep 2

# Installing skype
skype
if [[ $? == 0 ]];
  echo " #### Skype is Available #### "
else
  echo " #### Installing Skype #### "
  sudo wget https://go.skype.com/skypeforlinux-64.deb
  sudo dpkg -i skypeforlinux-64.deb &>> Not_Installed.txt
  if [[ $? == 0 ]]; then
   echo " ### Skype is Installed ### "
  else
    echo " ### 8.Skype is not Installed ### " >> Not_Installed.txt
  fi
fi
sleep 2

# Installing java Default Version
sudo $ptoin install software-properties-common -y
if [[ -f  /usr/lib/jvm]]; then
  while :
  do
  clear
     echo "#### Available Java Versions are #####" && ls /usr/lib/jvm |grep java
     echo
     echo "what do you want do?"
     echo " 1)Install Specific Version"
     echo " 2)Continue with Default"
     read -p "Select an option [1-2]: " option
     case $option in
            1)
            echo
            echo -n "Enter Java Version to Install:"
            read n
            echo "### Installing Java Version $n ###"
            sudo $ptoin install -y openjdk-$n-jre-headless &>> Not_Installed.txt
            if [[ $? == 0 ]]; then
              echo " Java Version $n is installed"
            else  
              echo "#### Java is not Installed ####"
              echo "9.Java is not Installed" >> Not_Installed.txt
            fi
            break
            ;;
            2)
            echo
            echo " Going to Next Installation Setup "
            break
            ;;
          esac
      done
else
  while :
  do
  clear
          echo " #### Java is not Installed #### "
          echo
          echo "what do you want to do?"
          echo "  1) Install Default Java"
          echo "  2) Install Specific Version"
          read -p "Select an option [1-2]: " option
          case $option in
          1)
            echo "### Installing Default Java ###"
            sudo $ptoin install -y default-jdk default-jre &>> Not_Installed.txt
            if [[ $? == 0 ]]; then
              echo " Default Java is installed"
            else  
              echo "#### Java is not Installed ####"
              echo "9.Java is not Installed" >> Not_Installed.txt
            fi
            break
            ;;
            2)
            echo
            echo -n "Enter Java Version to Install:"
            read n
            echo "### Installing Java Version $n ###"
            sudo $ptoin install -y openjdk-$n-jre-headless &>> Not_Installed.txt
            if [[ $? == 0 ]]; then
              echo " Java Version $n is installed"
            else  
              echo "#### Java is not Installed ####"
              echo "9.Java is not Installed" >> Not_Installed.txt
            fi
            break
            ;;
          esac
      done
fi

sleep 2

 # Installing Maven
#mvn --version
#if [[ $? == 0 ]]; then
#  echo "#### Maven is Installed ####"
#else
 # echo " ### Maven is not Installed ### "
  #echo " ### Installing Maven ### "
  #sudo $ptoin install maven $>> Not_Installed.txt
  #if [[ $? == 0 ]]; then
  #  echo "### Maven is Installed ###"
  #else
  #  echo "### Maven is not Installed ###"
   # echo "### 10.Maven is not Installed ###" >> Not_Installed.txt
  #fi
#fi

 # Installing Tomcat
 ls /etc/ |grep tomcat
 if [[ $? == 0 ]]; then
 echo " ##### Installed Tomcat Versions are ##### " $(ls /etc/ |grep tomcat)
 else
 while :
  do
  clear
          echo " #### Tomcat Server is not Installed #### "
          echo
          echo "what do you want to do?"
          echo "  1) Skip Installation"
          echo "  2) Install Specific Version"
          read -p "Select an option [1-2]: " option
          case $option in
          1)
            echo
            echo " #### Moving to Next Installation ####"
            break
            ;;
            2)
            echo
            echo -n "Enter Tomcat Version to Install:"
            read n
            echo "### Installing Tomcat Version $n ###"
            sudo $ptoin install -y tomcat$n &>> Not_Installed.txt
            if [[ $? == 0 ]]; then
              echo " Tomcat Version $n is installed"
            else  
              echo "#### Tomcat is not Installed ####"
              echo "11.Tomcat is not Installed" >> Not_Installed.txt
            fi
            break
            ;;
          esac
      done
fi  
sleep 2

#Installing MySQL
if [[ -e /etc/mysql/conf.d/mysql.cnf ]]; then
  echo " ##### MySQL Server is Installed ##### "
else
  while :
  do
  clear
    echo " ### MySQL Server is not Installed ### "
    echo " what do you want to do?"
    echo " 1)Skip_Installation"
    echo " 2)Install MySQL"
    read -p "Select an option [1-2]: " option
          case $option in
          1)
            echo
            echo " #### Moving to Next Installation ####"
            break
            ;;
          2)
            echo " #### Installing MySQL Server #### "
            sudo $ptoin install -y mysql-server mysql-client libmysqlclient-dev &>> Not_Installed.txt
            if [[ $? == 0 ]]; then
              echo "### MySQL Server Installed Successfully"
            else
              echo " ### MySQL is not Installed ### "
              echo " ### 12.MySQL is not Installed ### " >> Not_Installed.txt
            fi
            break
            ;;
          esac
    done
fi

#Installing PostgreSQL
sudo $ptoin update -y
if [[ -e /etc/postgresql ]]; then
  echo "### PostgreSQL is Installed & Versions are ####" $(ls /etc/postgresql)
else
  while :
  do
  clear
    echo " ### PostgreSQL is not Installed ### "
    echo
    echo " what do you want to do?"
    echo " 1)Skip_Installation"
    echo " 2)Install_PostgreSQL"
    read -p "Select an option [1-2]: " option
        case $option in
          1)
            echo
            echo " #### Moving to Next Installation ####"
            break
            ;;
          2)
            echo " #### Installing PostgreSQL Server #### "
            sudo $ptoin install -y postgresql &>> Not_Installed.txt
            if [[ $? == 0 ]]; then
              echo "### PostgreSQL Server Installed Successfully"
            else
              echo " ### PostgreSQL is not Installed ### "
              echo " ### 13.PostgreSQL is not Installed ### " >> Not_Installed.txt
            fi
            break
            ;;
        esac
   done
fi
sleep 2

#Installing Filezilla
#sudo $ptoin install filezilla

# Installing elasticsearch
if [[ -e /etc/elasticsearch ]]; then
  echo "##### Elastic Search is Installed #####"
  echo "##### Installed Elastic Search Versions #####"
  sudo dpkg -l | grep 'elastic' | tr -s ' ' | cut -d' ' -f2,3 | tr ' ' : | cut -d: -f1,2
else
  while :
  do
  clear
      echo "#### Elastic Search is not Installed ####"
      echo
      echo " What do you want to do?"
      echo "1)Skip_Installation"
      echo "2)Install Specific Version"
      read -p "Select an option [1-2]: " option
        case $option in
          1)
            echo
            echo " #### Moving to Next Installation ####"
            break
            ;;
          2)
            echo " #### Installing PostgreSQL Server #### "
            sudo wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
            sudo $ptoin-get install apt-transport-https
            echo " # Enter version in [5,6,7] # "
            echo -n "Enter version number without Decimal:"
            read n
            echo " ## Installing Elastic Search $n.x"
            echo "deb https://artifacts.elastic.co/packages/$n.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-$n.x.list
            sudo $ptoin install elasticsearch &>> Not_Installed.txt
            if [[ $? == 0 ]]; then
              echo "### Elasic Search $n.x Installed Successfully"
            else
              echo " ### Elasic Search $n is not Installed ### "
              echo " ### 14.Elasic Search $n is not Installed ### " >> Not_Installed.txt
            fi
            break
            ;;
        esac
   done
fi
sleep 2

# Installing MongoDB
if [[ -e /lib/systemd/system/mongod.service ]]; then
  echo " #### MongoDB is Installed #### "
  echo " ### Installed MongoDB Versions ### "
  sudo dpkg -l | grep 'mongo' | tr -s ' ' | cut -d' ' -f2,3 | tr ' ' : | cut -d: -f1,2
else
  while :
  do
  clear
      echo " ## MongoDB is not Installed ## "
      echo " What do you want to do?"
      echo "1)Skip_Installation"
      echo "2)Install MongoDB"
      read -p "Select an option [1-2]: " option
        case $option in
          1)
            echo
            echo " #### Moving to Next Installation ####"
            break
            ;;
          2)
            echo " #### Installing MongoDB Server #### "
            sudo wget -qO - https://www.mongodb.org/static/pgp/server-4.0.asc | sudo apt-key add -
            sudo echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
            sudo $ptoin-get update -y
            sudo $ptoin-get install -y mongodb-org
            if [[ $? == 0 ]]; then
              echo "### MongoDB Installed Successfully"
            else
              echo " ### MongoDB is not Installed ### "
              echo " ### 15.MongoDB is not Installed ### " >> Not_Installed.txt
            fi
            break
            ;;
        esac
   done
fi
sleep 2

# Installing Node
sudo dpkg -l | grep 'npm' | tr -s ' ' | cut -d' ' -f2,3 | tr ' ' : | cut -d: -f1,2
if [[ $? == 0 ]]; then
  echo " #### Nodejs is Availble & Versions are " $(sudo dpkg -l | grep 'npm' | tr -s ' ' | cut -d' ' -f2,3 | tr ' ' : | cut -d: -f1,2) "####"
  while :
  do
  clear
    echo
    echo " What do you want to do?"
    echo " 1)Install Specific Version"
    echo " 2)Skip Nodejs Setup or Continue"
    read -p "Select an option [1-2]: " option
    case $option in
          1)
            echo
            echo " #### Installatig Nodejs ####"
              while :
              do
              clear
                  echo " Select Versions of Nodejs to Install"
                  echo " 1)Node.js v12.x"
                  echo " 2)Node.js v11.x"
                  echo " 3)Node.js v10.x"
                  echo " 4)Node.js v8.x"
                  read -p "Select an option [1-4]: " option
                  case $option in
                        1)
                          echo
                          echo " ## Installing Nodejs v12.x ## "
                          curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
                          sudo $ptoin-get install -y nodejs
                          break
                          ;;
                        2)
                          echo
                          echo " ## Installing Nodejs v11.x ## "
                          curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
                          sudo $ptoin-get install -y nodejs
                          break
                          ;;
                        3)
                          echo
                          echo " ## Installing Nodejs v10.x ## "
                          curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
                          sudo $ptoin-get install -y nodejs
                          break
                          ;;
                        4)
                          echo
                          echo " ## Installing Nodejs v8.0 ## "
                          curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
                          sudo $ptoin-get install -y nodejs
                          break
                          ;;
                      esac
                  done  
            break
            ;;
          2)
            echo " #### Moving to Next Installation #### "
            break
            ;;
        esac
   done

else
    while :
    do
    clear
      echo " ### Nodejs is not Installed ### "
      echo " What do you want to do?"
      echo " 1)Install Specific Version"
      echo " 2)Skip Nodejs Setup"
      case $option in
          1)
            echo
            echo " #### Installatig Nodejs ####"
              while :
              do
              clear
                  echo " Select Versions of Nodejs to Install"
                  echo " 1)Node.js v12.x"
                  echo " 2)Node.js v11.x"
                  echo " 3)Node.js v10.x"
                  echo " 4)Node.js v8.x"
                  read -p "Select an option [1-4]: " option
                  case $option in
                        1)
                          echo
                          echo " ## Installing Nodejs v12.x ## "
                          curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
                          sudo $ptoin-get install -y nodejs
                          break
                          ;;
                        2)
                          echo
                          echo " ## Installing Nodejs v11.x ## "
                          curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
                          sudo $ptoin-get install -y nodejs
                          break
                          ;;
                        3)
                          echo
                          echo " ## Installing Nodejs v10.x ## "
                          curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
                          sudo $ptoin-get install -y nodejs
                          break
                          ;;
                        4)
                          echo
                          echo " ## Installing Nodejs v8.0 ## "
                          curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
                          sudo $ptoin-get install -y nodejs
                          break
                          ;;
                      esac
                  done  
            break
            ;;
          2)
            echo " #### Moving to Next Installation #### "
            break
            ;;
        esac
   done
 fi  

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
#if [ $ptoin=apt ] then
 #   clear
 #        echo " Your Machine is Ubuntu"
             
#sudo apt-get remove docker docker-engine docker.io containerd runc

#sudo apt-get update

#sudo apt-get install \
  #  apt-transport-https \
 #   ca-certificates \
   # curl \
    #gnupg-agent \
    #software-properties-common -y

#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#sudo apt-key fingerprint 0EBFCD88

#sudo add-apt-repository \
 #  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  # $(lsb_release -cs) \
   #stable"
#
#sudo apt-get update

#sudo apt-get install docker-ce docker-ce-cli containerd.io -y

#docker --version
#else [ $ptoin=yum ] then
#clear
 #    echo "Your Machine is Centos"
  #   sudo yum remove docker \
   #               docker-client \
    #              docker-client-latest \
     #             docker-common \
      #            docker-latest \
       ##          docker-logrotate \
         #         docker-engine
      #sudo yum install -y yum-utils \
      #device-mapper-persistent-data \
      #lvm2
      #sudo yum-config-manager \
      #--add-repo \
      #https://download.docker.com/linux/centos/docker-ce.repo
      #sudo yum install docker-ce docker-ce-cli containerd.io
      #sudo systemctl start docker
      #docker --version
#fi
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
#sudo $ptoin install openvpn -y

# Installing gnome tweak tool which contains adanced options for ubuntu gui
sudo add-$ptoin-repository universe
sudo $ptoin install gnome-tweak-tool
# Download STS 
#cd /opt/
#sudo wget https://download.springsource.com/release/STS/3.9.9.RELEASE/dist/e4.12/spring-tool-suite-3.9.9.RELEASE-e4.12.0-linux-gtk-x86_64.tar.gz
#sudo tar -xzvf spring-tool-suite-3.9.9.RELEASE-e4.12.0-linux-gtk-x86_64.tar.gz
#cd /opt/sts-bundle/sts-3.9.9.RELEASE
#cat << EOT > STS.desktop
#[Desktop Entry]
#Name=SpringSource Tool Suite
#Comment=SpringSource Tool Suite
#Exec=/opt/sts-bundle/sts-3.9.9.RELEASE/STS
#Icon=/opt/sts-bundle/sts-3.9.9.RELEASE/icon.xpm
#StartupNotify=true
#Terminal=false
##Type=Application
#Categories=Development;IDE;Java;
#EOT

#sudo mv STS.desktop /usr/share/applications/

sleep 5

