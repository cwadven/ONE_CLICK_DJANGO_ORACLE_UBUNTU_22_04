# cron 이 설치되어 있지 않은 경우가 있어 설치 및 활성화
sudo apt-get update -y
sudo apt-get install -y cron
sudo systemctl enable cron
sudo systemctl start cron

# cron 작업 결과 메일 전송에 쓰이는 MTA(postfix) 가 없으면
# sendmail: fatal: open /etc/postfix/main.cf 같은 에러가 발생한다.
# 대화형 설정을 건너뛰기 위해 "No configuration" 으로 비대화식 설치한다.
echo "postfix postfix/main_mailer_type select No configuration" | sudo debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y postfix
