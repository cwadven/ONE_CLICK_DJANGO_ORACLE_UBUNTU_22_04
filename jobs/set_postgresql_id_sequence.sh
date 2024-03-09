output=$(. $MY_PROJECT_DIRECTORY/venv/bin/activate && python $MY_PROJECT_DIRECTORY/manage.py showmigrations)

apps=""

while IFS= read -r line; do
    app_name=$(echo "$line" | awk '{print $1}')
    if [ -n "$app_name" ] && [ "$app_name" != "[]" ] && [ "$app_name" != "[X]" ] && [ "$app_name" != "(no" ]; then
        if [ -z "$apps" ]; then
            apps="$app_name"
        else
            apps="$apps $app_name"
        fi
    fi
done <<< "$output"

. $MY_PROJECT_DIRECTORY/venv/bin/activate && python $MY_PROJECT_DIRECTORY/manage.py sqlsequencereset $apps > $MY_PROJECT_DIRECTORY/set_postgresql_id_sequence.sql
sudo -u postgres psql -d $DATABASE_NAME -f $MY_PROJECT_DIRECTORY/set_postgresql_id_sequence.sql