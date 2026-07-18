if [ -e "$MY_PROJECT_DIRECTORY/crontab.j2" ];
then
. $MY_PROJECT_DIRECTORY/venv/bin/activate && cd $MY_PROJECT_DIRECTORY && fab2 update-crontab
if [ -e "$MY_PROJECT_DIRECTORY/command.cron" ];
then
cat $MY_PROJECT_DIRECTORY/command.cron | sudo crontab -
sudo /etc/init.d/cron reload
else
echo "command.cron file does not exist (fab2 update-crontab 실패 가능성 - fab2 설치 및 crontab.j2 확인 필요)"
fi
else
echo "crontab.j2 file does not exist"
fi
