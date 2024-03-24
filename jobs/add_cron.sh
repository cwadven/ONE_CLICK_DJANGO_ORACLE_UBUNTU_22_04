if [ -e "$MY_PROJECT_DIRECTORY/crontab.j2" ];
then
. $MY_PROJECT_DIRECTORY/venv/bin/activate && cd $MY_PROJECT_DIRECTORY && fab2 update-crontab
cat $MY_PROJECT_DIRECTORY/command.cron | sudo crontab -
sudo /etc/init.d/cron reload
else
echo "crontab.j2 file does not exist"
fi
