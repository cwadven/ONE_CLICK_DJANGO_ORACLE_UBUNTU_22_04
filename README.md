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

> ⚠️ **DATABASE 블록을 꼭 채우세요.**
> 데이터베이스 이름/유저/비밀번호는 더 이상 스크립트 실행 중에 직접 입력받지 않고,
> `.django_env` 의 `DATABASE` 블록에서 그대로 읽어와 DB 를 생성합니다.
> 아래 값들을 실제 값으로 채워주세요. (`NAME`, `USER`, `PASSWORD`, `TEST.NAME` 는 필수)
>
> ```json
> "DATABASE": {
>     "ENGINE": "django.db.backends.postgresql",
>     "NAME": "여기에_DB이름",
>     "USER": "여기에_DB유저",
>     "PASSWORD": "여기에_DB비밀번호",
>     "HOST": "localhost",
>     "PORT": "5432",
>     "TEST": {
>         "NAME": "여기에_테스트DB이름"
>     }
> }
> ```
>
> 이 블록이 비어있거나 형식이 잘못되면 스크립트가 시작 단계에서 멈춥니다.

#### 1. root 권한으로 실행
(pip install 에서 문제가 생겨서 root 권한 실행 )

```
sudo su -

cd ~

sudo apt install git

git clone https://github.com/cwadven/ONE_CLICK_DJANGO_UBUNTU_26_04.git

cd ONE_CLICK_DJANGO_UBUNTU_26_04
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
