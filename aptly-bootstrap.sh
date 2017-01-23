echo "deb http://repo.aptly.info/ squeeze main" >> /etc/apt/sources.list
sudo apt-key adv --keyserver keys.gnupg.net --recv-keys 9E3E53F19C7DE460
sudo apt-get update
sudo apt-get install aptly
sudo apt-get install gnupg
