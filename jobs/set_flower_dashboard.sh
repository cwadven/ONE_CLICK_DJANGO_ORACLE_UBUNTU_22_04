cd /etc/systemd/system/
cat <<EOF | sudo tee celery-flower.service
[Unit]
Description=Celery Flower Service
After=network.target

[Service]
User=django
Group=djangogroup
WorkingDirectory=$MY_PROJECT_DIRECTORY
ExecStart=$MY_PROJECT_DIRECTORY/venv/bin/celery -A config flower --address=0.0.0.0 --port=5555 --basic_auth=$FLOWER_USERNAME:$FLOWER_PASSWORD
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

sudo apt-get install firewalld -y
sudo firewall-cmd --zone=public --add-port=5555/tcp --permanent
sudo firewall-cmd --reload
sudo ufw allow 5555

sudo systemctl daemon-reload
sudo systemctl start celery-flower.service
sudo systemctl enable celery-flower.service