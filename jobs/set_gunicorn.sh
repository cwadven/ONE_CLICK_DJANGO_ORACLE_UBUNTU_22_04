echo "log 폴더 확인중 ..."
if [ ! -d "/var/log/gunicorn" ];
then
    echo "log 폴더가 존재하지 않습니다. 생성 중..."
    mkdir -p /var/log/gunicorn
else
    echo "already exists"
fi

echo "access log 파일 확인중 ..."
if [ -e "/var/log/gunicorn/access.log" ];
then
    echo "already exists"
else
    echo "access log 파일이 존재하지 않습니다. 생성 중..."
    sudo touch /var/log/gunicorn/access.log
fi

echo "error log 파일 확인중 ..."
if [ -e "/var/log/gunicorn/error.log" ];
then
    echo "already exists"
else
    echo "error log 파일이 존재하지 않습니다. 생성 중..."
    sudo touch /var/log/gunicorn/error.log
fi

echo "권한 설정중 ..."
sudo chown -R django:www-data /var/log/gunicorn
sudo chmod -R 755 /var/log/gunicorn

if [ -e "$MY_PROJECT_DIRECTORY/app.log" ];
then
echo "already exists"
else
cd $MY_PROJECT_DIRECTORY && cat <<EOF | sudo tee app.log
[loggers]
EOF
sudo chown django:www-data app.log

cd /etc/systemd/system/
cat <<EOF | sudo tee gunicorn.service
[Unit]
Description=gunicorn daemon for Django
After=network.target

[Service]
User=django
Group=www-data
WorkingDirectory=$MY_PROJECT_DIRECTORY
Environment="DJANGO_SETTINGS_MODULE=$CONFIG_SETTINGS"
ExecStart=$MY_PROJECT_DIRECTORY/venv/bin/gunicorn --workers=3 --bind 0.0.0.0:8000 --access-logfile /var/log/gunicorn/access.log --error-logfile /var/log/gunicorn/error.log config.wsgi:application

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl stop gunicorn
sudo systemctl start gunicorn
sudo systemctl enable gunicorn
fi
