sudo apt-get -y install nginx

if [ -f "/etc/nginx/sites-available/$PROJECT_NAME" ];
then
echo "already exists"
else
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/$PROJECT_NAME
sudo ln -s /etc/nginx/sites-available/$PROJECT_NAME /etc/nginx/sites-enabled
sudo rm /etc/nginx/sites-enabled/default

# nginx 설정 수정
sudo sed -i 's/# server_names_hash_bucket_size 64;/server_names_hash_bucket_size 128;/g' /etc/nginx/nginx.conf

cd /etc/nginx/sites-available/

cat <<EOF | sudo tee $PROJECT_NAME
server {
    listen 80;
    server_name localhost;
    client_max_body_size 100M;
    charset utf-8;

    location / {
        proxy_pass http://localhost:8000;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }

    location /static/ {
        alias $MY_PROJECT_DIRECTORY/static/;
    }
}
EOF
fi