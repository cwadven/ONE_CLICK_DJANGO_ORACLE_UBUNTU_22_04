sudo groupadd djangogroup
sudo useradd -g djangogroup -b /home -m -s /bin/bash django

if [ -d "/var/www/$PROJECT_NAME" ];
then
echo "project already exists"
else
cd /var/www && sudo git clone $GIT_URL
sudo chown django:djangogroup $MY_PROJECT_DIRECTORY
sudo usermod -a -G djangogroup $SERVER_USER_NAME
sudo chmod g+w $MY_PROJECT_DIRECTORY
fi