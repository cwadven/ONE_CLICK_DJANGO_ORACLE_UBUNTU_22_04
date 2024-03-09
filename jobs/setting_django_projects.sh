if [ -d "$MY_PROJECT_DIRECTORY/temp_static" ];
then
echo "already exists"
else
cd $MY_PROJECT_DIRECTORY && sudo mkdir temp_static
fi

if [ -e "$MY_PROJECT_DIRECTORY/$PASTE_DJANGO_ENV_FOLDER_PATH$DJANGO_ENV_FILE_NAME" ];
then
echo "already exists"
else
cp $DJANGO_ENV_FILE_PATH $MY_PROJECT_DIRECTORY/$PASTE_DJANGO_ENV_FOLDER_PATH$DJANGO_ENV_FILE_NAME
sudo chown -R django:djangogroup $MY_PROJECT_DIRECTORY/$PASTE_DJANGO_ENV_FOLDER_PATH$DJANGO_ENV_FILE_NAME
fi

. $MY_PROJECT_DIRECTORY/venv/bin/activate && python $MY_PROJECT_DIRECTORY/manage.py collectstatic --noinput