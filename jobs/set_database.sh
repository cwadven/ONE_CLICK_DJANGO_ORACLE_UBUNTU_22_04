cd $CURRENT_FOLDER

if [[ ! -z "`psql -qAt --list | grep $DATABASE_NAME`" ]];
then
echo "database already exists"
else
psql -c "CREATE USER $DATABASE_USER_NAME WITH PASSWORD '$DATABASE_USER_PASSWORD'";
psql -c "CREATE DATABASE $DATABASE_NAME WITH ENCODING 'UTF8' OWNER $DATABASE_USER_NAME;"
psql -c "CREATE DATABASE $TEST_DATABASE_NAME WITH ENCODING 'UTF8' OWNER $DATABASE_USER_NAME;"
fi