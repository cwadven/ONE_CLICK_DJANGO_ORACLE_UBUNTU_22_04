if [ -e "$MY_PROJECT_DIRECTORY/command.cron" ];
then
cat $MY_PROJECT_DIRECTORY/command.cron | sudo crontab -
sudo /etc/init.d/cron reload
else
echo "command.cron file does not exist"
fi