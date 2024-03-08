cd $CURRENT_FOLDER

if [[ ! -z "`psql -qAt --list | grep $DATABASE_NAME`" ]];
then
echo "database already exists"
else
sudo -u postgres psql -c "CREATE USER $DATABASE_USER_NAME WITH PASSWORD '$DATABASE_USER_PASSWORD'";
sudo -u postgres psql -c "CREATE DATABASE $DATABASE_NAME WITH ENCODING 'UTF8' OWNER $DATABASE_USER_NAME;"
sudo -u postgres psql -c "CREATE DATABASE $TEST_DATABASE_NAME WITH ENCODING 'UTF8' OWNER $DATABASE_USER_NAME;"
fi