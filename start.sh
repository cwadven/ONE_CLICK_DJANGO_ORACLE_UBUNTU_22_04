echo "Example) /opt/.django_env"
read -p "Enter .django_env file path: " DJANGO_ENV_FILE_PATH

if [ ! -f $DJANGO_ENV_FILE_PATH ]; then
    echo ".django_env File not found"
    exit 1
fi

echo "Example) If it is project root directory, enter empty string or if it is inside the directory, config/settings/ (need to enter last at folder '/'!!!)"
read -p "Enter where directory .django_env file paste: " PASTE_DJANGO_ENV_FOLDER_PATH

echo "Example) https://github.com/cwadven/NullyDRFTemplate.git"
read -p "Enter Git Project Url: " GIT_URL

echo "Example) config.settings.production"
read -p "Enter project settings file of django without extension: " CONFIG_SETTINGS

echo "Example) ubuntu"
read -p "Enter Ubuntu Server User Name: " SERVER_USER_NAME

echo "Example) blog"
read -p "Enter New Database Name: " DATABASE_NAME

echo "Example) test_blog"
read -p "Enter New Test Database Name: " TEST_DATABASE_NAME

echo "Example) blog_user"
read -p "Enter New Database User Name: " DATABASE_USER_NAME

echo "Example) passwordsomething"
read -p "Enter New Database User Password: " DATABASE_USER_PASSWORD

echo "Example) blog"
read -p "Enter Flower Username: " FLOWER_USERNAME

echo "Example) password"
read -p "Enter Flower password: " FLOWER_PASSWORD

with_git=(${GIT_URL##*/})
split_with_git=(${with_git//./ })
PROJECT_NAME=(${split_with_git[0]})

with_path=(${DJANGO_ENV_FILE_PATH##*/})
split_with_path=(${with_path//./ })
DJANGO_ENV_FILE_NAME=(${split_with_path[0]})

MY_PROJECT_DIRECTORY=/var/www/${PROJECT_NAME}

CURRENT_FOLDER=$PWD

export GIT_URL
export PROJECT_NAME
export MY_PROJECT_DIRECTORY
export CONFIG_SETTINGS
export DJANGO_SETTINGS_MODULE=$CONFIG_SETTINGS
export DATABASE_NAME
export TEST_DATABASE_NAME
export DATABASE_USER_NAME
export DATABASE_USER_PASSWORD
export SERVER_USER_NAME
export DJANGO_ENV_FILE_PATH
export DJANGO_ENV_FILE_NAME
export PASTE_DJANGO_ENV_FOLDER_PATH
export FLOWER_USERNAME
export FLOWER_PASSWORD

export CURRENT_FOLDER

# script 를 단계별로 실행
echo "================start update_linux.sh=================="
. "$CURRENT_FOLDER/jobs/update_linux.sh"

echo "================start open_filewall.sh=================="
. "$CURRENT_FOLDER/jobs/open_filewall.sh"

echo "================start intall_and_set_nginx.sh=================="
. "$CURRENT_FOLDER/jobs/intall_and_set_nginx.sh"

echo "================start set_project_directory_and_create_user_group.sh=================="
. "$CURRENT_FOLDER/jobs/set_project_directory_and_create_user_group.sh"

echo "================start install_python3_11_and_postgresql_lib.sh=================="
. "$CURRENT_FOLDER/jobs/install_python3_11_and_postgresql_lib.sh"

echo "================start install_postgresql14.sh=================="
. "$CURRENT_FOLDER/jobs/install_postgresql14.sh"

echo "================start install_redis.sh=================="
. "$CURRENT_FOLDER/jobs/install_redis.sh"

echo "================start install_pip_modules.sh=================="
. "$CURRENT_FOLDER/jobs/install_pip_modules.sh"

echo "================start set_database.sh=================="
. "$CURRENT_FOLDER/jobs/set_database.sh"

echo "================start set_gunicorn.sh=================="
. "$CURRENT_FOLDER/jobs/set_gunicorn.sh"

echo "================start setting_django_projects.sh=================="
. "$CURRENT_FOLDER/jobs/setting_django_projects.sh"

echo "================start django_migrate.sh=================="
. "$CURRENT_FOLDER/jobs/django_migrate.sh"

echo "================start restart_services.sh=================="
. "$CURRENT_FOLDER/jobs/restart_services.sh"

echo "================start set_celery.sh=================="
. "$CURRENT_FOLDER/jobs/set_celery.sh"

echo "================start set_flower_dashboard.sh=================="
. "$CURRENT_FOLDER/jobs/set_flower_dashboard.sh"

echo "================start add_cron.sh=================="
. "$CURRENT_FOLDER/jobs/add_cron.sh"

unset GIT_URL
unset PROJECT_NAME
unset MY_PROJECT_DIRECTORY
unset CONFIG_SETTINGS
unset DJANGO_SETTINGS_MODULE
unset CURRENT_FOLDER
unset DATABASE_NAME
unset TEST_DATABASE_NAME
unset DATABASE_USER_NAME
unset DATABASE_USER_PASSWORD
unset SERVER_USER_NAME
unset DJANGO_ENV_FILE_PATH
unset DJANGO_ENV_FILE_NAME
unset PASTE_DJANGO_ENV_FOLDER_PATH
unset FLOWER_USERNAME
unset FLOWER_PASSWORD