# 앱 라벨을 Django 앱 레지스트리에서 직접 추출한다.
# showmigrations stdout 을 파싱하면 앱 초기화 시 찍히는 print(예: Firebase 초기화 실패)가
# 앱 이름으로 잘못 섞여 들어가므로, 고유 마커(APPLABEL:)를 붙여 출력한 뒤 그 줄만 걸러낸다.
apps=$(. $MY_PROJECT_DIRECTORY/venv/bin/activate && cd $MY_PROJECT_DIRECTORY && \
    python manage.py shell -c "from django.apps import apps; print('\n'.join('APPLABEL:'+a.label for a in apps.get_app_configs()))" 2>/dev/null \
    | grep '^APPLABEL:' | sed 's/^APPLABEL://' | tr '\n' ' ')

# sqlsequencereset 출력에서 실제 SQL 문장 줄만 남겨 .sql 을 생성한다.
# (앱 초기화 print 등 비 SQL 오염 줄은 제거되어 psql syntax error 를 방지한다)
. $MY_PROJECT_DIRECTORY/venv/bin/activate && cd $MY_PROJECT_DIRECTORY && \
    python manage.py sqlsequencereset $apps 2>/dev/null \
    | grep -iE '^[[:space:]]*(SELECT|ALTER|BEGIN|COMMIT|SET|--)' \
    > $MY_PROJECT_DIRECTORY/set_postgresql_id_sequence.sql

# 생성된 SQL 이 비어있지 않을 때만 실행한다.
if [ -s "$MY_PROJECT_DIRECTORY/set_postgresql_id_sequence.sql" ];
then
    sudo -u postgres psql -d $DATABASE_NAME -f $MY_PROJECT_DIRECTORY/set_postgresql_id_sequence.sql
else
    echo "생성된 sequence reset SQL 이 비어있어 psql 실행을 건너뜁니다."
fi
