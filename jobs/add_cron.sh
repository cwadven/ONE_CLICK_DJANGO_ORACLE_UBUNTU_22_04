ENV_FILE="$MY_PROJECT_DIRECTORY/$DJANGO_ENV_FILE_NAME"

if [ -e "$MY_PROJECT_DIRECTORY/crontab.j2" ];
then
    # fabfile 의 update-crontab 은 .django_env 의 CRONTAB_PREFIX_COMMAND 를 필수로 요구한다.
    # 값이 없으면 예외로 죽으므로, 없으면 cron 설정 자체를 건너뛴다.
    if ! grep -qE '^[[:space:]]*CRONTAB_PREFIX_COMMAND[[:space:]]*=' "$ENV_FILE" 2>/dev/null;
    then
        echo "CRONTAB_PREFIX_COMMAND 가 .django_env 에 없어 cron 설정을 건너뜁니다."
    else
        . $MY_PROJECT_DIRECTORY/venv/bin/activate && cd $MY_PROJECT_DIRECTORY && fab2 update-crontab
        if [ -e "$MY_PROJECT_DIRECTORY/command.cron" ];
        then
            cat $MY_PROJECT_DIRECTORY/command.cron | sudo crontab -
            sudo /etc/init.d/cron reload
        else
            echo "command.cron file does not exist (fab2 update-crontab 실패 가능성 - fab2 설치 및 crontab.j2 확인 필요)"
        fi
    fi
else
    echo "crontab.j2 file does not exist"
fi
