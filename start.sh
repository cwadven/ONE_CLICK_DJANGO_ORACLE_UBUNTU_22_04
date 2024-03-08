# Set Django project with git url
echo "Example) /opt/.django_env"
read -p "Enter .django_env file path: " DJANGO_ENV_FILE

if [ ! -f $DJANGO_ENV_FILE ]; then
    echo ".django_env File not found"
    exit 1
fi

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

with_git=(${GIT_URL##*/})
split_with_git=(${with_git//./ })
PROJECT_NAME=(${split_with_git[0]})

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
export DJANGO_ENV_FILE

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
unset DJANGO_ENV_FILE