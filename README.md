Задание для итоговой аттестации:

Необходимо подготовить код, который запускает веб сервер и доступна страница вида:
<DevOps Course 2021>
Веб сервер должен быть запущен в инфраструктуре AWS в новой VPC.
Конфигурирование веб сервера должно быть с помощью Ansible
Сам веб сервер необходимо запустить в docker контейнере.
Код выложить в репозиторий Github. В репозитории должны быть добавлены автоматические проверки `ansible lint` и `terraform validate`. Все изменения могут происходить только через отдельную ветку.
Код должен содержать все best practices которые были пройдены в течении курса.


Создание VM выполняется с использованием terraform.
1. Для запуска создания ВМ на amazon необходимо выполнить команду terraform apply
2. Для конфигурирования веб-сервера на запущенной ноде необходим выполнить команду:
   ansible-playbook prod/server.yml -i prod/hosts.yml

Структура проекта:

Task_Final/
├── README.md
├── ansible
│   ├── docker
│   │   ├── docker-compose.yml
│   │   └── nginx
│   │       ├── Dockerfile
│   │       ├── README.md
│   │       ├── nginx-conf
│   │       │   ├── default.conf
│   │       │   └── nginx.conf
│   │       ├── nginx-server.sh
│   │       └── site
│   │           └── index.html
│   └── prod
│       ├── host_vars
│       │   └── web-server
│       ├── hosts.yml
│       ├── roles
│       │   ├── common
│       │   │   ├── handlers
│       │   │   │   └── main.yml
│       │   │   └── tasks
│       │   │       ├── docker.yml
│       │   │       └── main.yml
│       │   └── nginx_docker
│       │       └── tasks
│       │           └── main.yml
│       └── server.yml
└── terraform-ec2
    ├── main.tf
    ├── output.tf
    └── variables.tf
