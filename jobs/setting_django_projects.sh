if [ -d "$MY_PROJECT_DIRECTORY/temp_static" ];
then
echo "already exists"
else
cd $MY_PROJECT_DIRECTORY && sudo mkdir temp_static
fi

if [ -e "$MY_PROJECT_DIRECTORY/$COPY_DJANGO_ENV_FILE_PATH.django_env" ];
then
echo "already exists"
cp $DJANGO_ENV_FILE $MY_PROJECT_DIRECTORY/$COPY_DJANGO_ENV_FILE_PATH.django_env
sudo chown -R django:djangogroup $MY_PROJECT_DIRECTORY/$COPY_DJANGO_ENV_FILE_PATH.django_env

. $MY_PROJECT_DIRECTORY/venv/bin/activate && python $MY_PROJECT_DIRECTORY/manage.py collectstatic --noinput