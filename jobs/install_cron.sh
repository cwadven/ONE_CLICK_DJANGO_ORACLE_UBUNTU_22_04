# cron 이 설치되어 있지 않은 경우가 있어 설치 및 활성화
sudo apt-get update -y
sudo apt-get install -y cron
sudo systemctl enable cron
sudo systemctl start cron
