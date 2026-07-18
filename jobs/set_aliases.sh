# sudo su - (root 로그인 셸) 에서 사용할 alias 를 /root/.bashrc 에 등록한다.
# cu alias 에서 dos2unix 를 사용하므로 함께 설치한다.
sudo apt-get install -y dos2unix

ROOT_BASHRC="/root/.bashrc"
MARKER_BEGIN="# ONE_CLICK_DJANGO_ALIASES_BEGIN"
MARKER_END="# ONE_CLICK_DJANGO_ALIASES_END"

# 재실행 시 중복 방지를 위해 기존 블록 제거
sudo sed -i "/$MARKER_BEGIN/,/$MARKER_END/d" "$ROOT_BASHRC"

# alias 블록 추가 (프로젝트 경로는 $MY_PROJECT_DIRECTORY 로 채워짐)
sudo tee -a "$ROOT_BASHRC" > /dev/null <<EOF
$MARKER_BEGIN
alias srn='systemctl restart nginx'
alias srg='systemctl restart gunicorn'
alias src='service celeryd restart'
alias srcf='systemctl restart celery-flower.service'
alias gp='git pull'
alias goto='cd $MY_PROJECT_DIRECTORY && source venv/bin/activate'
alias cu='mkdir -p /tmp/log && cd $MY_PROJECT_DIRECTORY && source venv/bin/activate && fab2 update-crontab && dos2unix command.cron && chmod 0644 command.cron && cat command.cron | crontab - && service cron restart'
$MARKER_END
EOF

echo "alias 등록 완료. 'sudo su -' 로 다시 로그인하거나 'source /root/.bashrc' 후 사용하세요."
