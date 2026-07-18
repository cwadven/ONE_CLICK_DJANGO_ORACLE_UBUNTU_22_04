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

echo "Example) main (비우고 Enter 시 저장소 기본 브랜치 사용)"
read -p "Enter Git Branch: " GIT_BRANCH

echo "Example) config.settings.production"
read -p "Enter project settings file of django without extension: " CONFIG_SETTINGS

echo "Example) ubuntu"
read -p "Enter Ubuntu Server User Name: " SERVER_USER_NAME

# DATABASE 정보는 직접 입력받지 않고 .django_env 의 DATABASE 블록에서 그대로 읽어온다.
echo "DATABASE 정보를 .django_env 의 DATABASE 블록에서 읽어옵니다."
DB_VALUES=$(python3 -c "
import json, sys
try:
    d = json.load(open('$DJANGO_ENV_FILE_PATH'))['DATABASE']
except Exception as e:
    sys.stderr.write('DATABASE 파싱 실패: %s\n' % e)
    sys.exit(1)
print(d.get('NAME', ''))
print(d.get('TEST', {}).get('NAME', ''))
print(d.get('USER', ''))
print(d.get('PASSWORD', ''))
")

if [ $? -ne 0 ]; then
    echo ".django_env 를 JSON 으로 읽지 못했습니다. DATABASE 블록 형식을 확인하세요."
    exit 1
fi

{
    read -r DATABASE_NAME
    read -r TEST_DATABASE_NAME
    read -r DATABASE_USER_NAME
    read -r DATABASE_USER_PASSWORD
} <<EOF
$DB_VALUES
EOF

if [ -z "$DATABASE_NAME" ] || [ -z "$TEST_DATABASE_NAME" ] || [ -z "$DATABASE_USER_NAME" ] || [ -z "$DATABASE_USER_PASSWORD" ]; then
    echo ".django_env 의 DATABASE 블록에 NAME / TEST.NAME / USER / PASSWORD 를 모두 채워주세요."
    exit 1
fi

echo "DATABASE_NAME: $DATABASE_NAME / TEST: $TEST_DATABASE_NAME / USER: $DATABASE_USER_NAME"

echo "Example) blog"
read -p "Enter Flower Username: " FLOWER_USERNAME

echo "Example) password"
read -p "Enter Flower password: " FLOWER_PASSWORD

with_git=(${GIT_URL##*/})
split_with_git=(${with_git//./ })
PROJECT_NAME=(${split_with_git[0]})

DJANGO_ENV_FILE_NAME=$(basename "$DJANGO_ENV_FILE_PATH")

MY_PROJECT_DIRECTORY=/var/www/${PROJECT_NAME}

CURRENT_FOLDER=$PWD

export GIT_URL
export GIT_BRANCH
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

echo "================start install_python_and_postgresql_lib.sh=================="
. "$CURRENT_FOLDER/jobs/install_python_and_postgresql_lib.sh"

echo "================start install_postgresql17.sh=================="
. "$CURRENT_FOLDER/jobs/install_postgresql17.sh"

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

echo "================start set_postgresql_id_sequence.sh=================="
. "$CURRENT_FOLDER/jobs/set_postgresql_id_sequence.sh"

echo "================start restart_services.sh=================="
. "$CURRENT_FOLDER/jobs/restart_services.sh"

echo "================start set_celery.sh=================="
. "$CURRENT_FOLDER/jobs/set_celery.sh"

echo "================start set_flower_dashboard.sh=================="
. "$CURRENT_FOLDER/jobs/set_flower_dashboard.sh"

echo "================start install_cron.sh=================="
. "$CURRENT_FOLDER/jobs/install_cron.sh"

echo "================start add_cron.sh=================="
. "$CURRENT_FOLDER/jobs/add_cron.sh"

echo "================start set_aliases.sh=================="
. "$CURRENT_FOLDER/jobs/set_aliases.sh"

unset GIT_URL
unset GIT_BRANCH
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