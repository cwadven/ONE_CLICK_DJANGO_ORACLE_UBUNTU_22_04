# vi /var/www/null_blog/config/settings.py
# 추가 작업 settings.py DEBUG 랑 ALLOW_IP 바꾸기
if [ -d "$MY_PROJECT_DIRECTORY/temp_static" ];
then
echo "already exists"
else
cd $MY_PROJECT_DIRECTORY && sudo mkdir temp_static
cp $DJANGO_ENV_FILE $MY_PROJECT_DIRECTORY/.django_env
sudo chown -R django:djangogroup $MY_PROJECT_DIRECTORY/.django_env
fi

. $MY_PROJECT_DIRECTORY/venv/bin/activate && python $MY_PROJECT_DIRECTORY/manage.py collectstatic --noinput