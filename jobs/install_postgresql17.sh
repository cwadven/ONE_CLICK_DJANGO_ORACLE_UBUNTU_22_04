# PostgreSQL 공식 저장소(PGDG) 추가 후 버전 17 고정 설치
sudo apt-get update -y
sudo apt-get install -y postgresql-common
sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh -y
sudo apt-get update -y
sudo apt-get -y install postgresql-17 postgresql-client-17 postgresql-contrib-17
