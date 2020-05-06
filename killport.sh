#!/bin/sh

if [ "$(id -u)" != "0" ];then
    echo "$(tput setaf 1)This script must be run as root";
    exit 1;
fi

rm -rf /bin/killport

tee -a /bin/killport > /dev/null <<EOT
#!/bin/sh
PORT=\$1;

if [ ! -n "\$1" ]; then
  echo "\$(tput setaf 1)Port not found";
else
  fuser -n tcp -k \$PORT;
fi
EOT

chmod -R 755 /bin/killport;

echo "$(tput setaf 2)Install success";
