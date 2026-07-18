# 원앤터 Django Ubuntu 배포

#### Canonical-Ubuntu-26.04 Version (Google Cloud Instance)

---

### Requirements

![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54) Version 3.14 (Ubuntu 26.04 기본) <br>
![Redis](https://img.shields.io/badge/redis-%23DD0031.svg?style=for-the-badge&logo=redis&logoColor=white) (Celery, Cache) <br>
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white) Version 17 (PGDG) <br>
![Django](https://img.shields.io/badge/django-%23092E20.svg?style=for-the-badge&logo=django&logoColor=white) Version 5.2.16 <br>
![Celery](https://img.shields.io/badge/celery-%23092E20.svg?style=for-the-badge&logo=celery&logoColor=white) <br>
![Flower](https://img.shields.io/badge/flower-%23092E20.svg?style=for-the-badge&logo=flower&logoColor=white) <br>

### 아래 작업은 생성한 Google Cloud Instance 에서 하세요

#### -1. 기본 설정

```
sudo apt-get update
sudo apt-get install vim
```

#### 0. .env 파일 어딘가 생성
```
sudo vi /opt/.django_env
```

#### 1. root 권한으로 실행
(pip install 에서 문제가 생겨서 root 권한 실행 )

```
sudo su -

cd ~

sudo apt install git

git clone https://github.com/cwadven/ONE_CLICK_DJANGO_ORACLE_UBUNTU_22_04.git

cd ONE_CLICK_DJANGO_ORACLE_UBUNTU_22_04
```

## CRON 수행 잘되게...

- cron 자체가 설치되어 있지 않은 경우가 있으니 먼저 설치/활성화 해주세요.

```
sudo apt-get update
sudo apt-get install -y cron
sudo systemctl enable cron
sudo systemctl start cron
```

- sudo apt-get update
- sudo apt-get install -y postfix

세팅으로는 no configure... 설정

CRON 작업하는 경우 위 패키지가 없으면 아래와 가튼 에러가 나옵니다.
```
Mar 24 07:20:01 XXXXXX-dev cron[249758]: sendmail: fatal: open /etc/postfix/main.cf: No such file or directory
Mar 24 07:20:01 XXXXXX-dev postfix/sendmail[249758]: fatal: open /etc/postfix/main.cf: No such file or directory
Mar 24 07:20:01 XXXXXX-dev CRON[249755]: (root) MAIL (mailed 30 bytes of output but got status 0x004b from MTA
                                        )
Mar 24 07:20:01 XXXXXX-dev CRON[249755]: pam_unix(cron:session): session closed for user root
Mar 24 07:21:01 XXXXXX-dev CRON[249772]: pam_unix(cron:session): session opened for user root(uid=0) by (uid=0)
Mar 24 07:21:01 XXXXXX-dev CRON[249773]: (root) CMD (source /var/www/XXXXXX/venv/bin/activate && cd /var/www/XXXXXX && python manage.py check >> /tmp/log/django_commands.log 2>&1)
Mar 24 07:21:01 XXXXXX-dev cron[249774]: sendmail: fatal: bad string length 0 < 1: setgid_group =
Mar 24 07:21:01 XXXXXX-dev postfix/sendmail[249774]: fatal: bad string length 0 < 1: setgid_group =
Mar 24 07:21:01 XXXXXX-dev CRON[249772]: (root) MAIL (mailed 30 bytes of output but got status 0x004b from MTA
                                        )
```

#### 2. 스크립트 실행

```
/bin/bash start.sh
```

## Github 권한 나올때

https://github.com/settings/tokens 들어가서 token classic 생성 하나 하고 토큰 저장하고 비밀번호에 토큰 등록


Google Cloud 용 방법
https://cwbeany.com/tip_dev/77
