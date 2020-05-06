#!/bin/bash

function is_installed() {
  # set to 1 initially
  local return_=1
  # set to 0 if not found
  type $1 >/dev/null 2>&1 || { local return_=0; }
  # return
  echo "$return_"
}

function install_node() {

  echo "Updating server"
  apt-get update

  echo "Install Nodejs Server Nginx Redis"

  if [ "$(is_installed nginx)" == "0" ]; then
    echo "Installing nginx"
    apt-get install nginx -y
    echo "Start nginx"
    systemctl start nginx
    echo "Auto enable nginx when server reboot"
    systemctl enable nginx
  fi

  if [ "$(is_installed make)" == "0" ]; then
    echo "Installing build-essential"
    apt-get install build-essential -y
  fi

  if [ "$(is_installed node)" == "0" ]; then
    echo "Download nodejs 13"
    curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
    echo "Installing nodejs"
    apt-get install nodejs -y
    node --version
  fi

  if [ "$(is_installed git)" == "0" ]; then
    echo "Installing git"
    apt-get install git -y
  fi

  if [ "$(is_installed pm2)" == "0" ]; then
    echo "Installing pm2"
    npm i -g pm2
  fi

  if [ "$(is_installed redis-cli)" == "0" ]; then
    echo "Installing redis"
    apt-get install redis-server
  fi

}

install_node;

done;
