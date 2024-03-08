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
User=ubuntu
Group=www-data
WorkingDirectory=$MY_PROJECT_DIRECTORY
Environment="DJANGO_SETTINGS_MODULE=$CONFIG_SETTINGS"
ExecStart=$MY_PROJECT_DIRECTORY/venv/bin/gunicorn --workers=3 --bind 0.0.0.0:8000 config.wsgi:application

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl stop gunicorn
sudo systemctl start gunicorn
sudo systemctl enable gunicorn
fi