# 원앤터 Django Ubuntu 배포

#### Canonical-Ubuntu-22.04 Version (Oracle Cloud Instance)

---

### Requirements

![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54) Version 3.11 <br>
![Redis](https://img.shields.io/badge/redis-%23DD0031.svg?style=for-the-badge&logo=redis&logoColor=white) (Celery, Cache) <br>
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white) Version 14 <br>
![Django](https://img.shields.io/badge/django-%23092E20.svg?style=for-the-badge&logo=django&logoColor=white) Version 4.1.10 <br>
![Celery](https://img.shields.io/badge/celery-%23092E20.svg?style=for-the-badge&logo=celery&logoColor=white) <br>
![Flower](https://img.shields.io/badge/flower-%23092E20.svg?style=for-the-badge&logo=flower&logoColor=white) <br>

### 아래 작업은 생성한 Oracle Cloud Instance 에서 하세요

#### 0. .env 파일 어딘가 생성
```
vi /opt/.django_env
```

#### 1. root 권한으로 실행
(pip install 에서 문제가 생겨서 root 권한 실행 )

```
sudo su -

cd ~

git clone https://github.com/cwadven/ONE_CLICK_DJANGO_ORACLE_UBUNTU_22_04.git

cd ONE_CLICK_DJANGO_ORACLE_UBUNTU_22_04
```

#### 2. 스크립트 실행

```
/bin/bash start.sh
```
