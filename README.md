# Flask Blank Project

Пустой проект Flask с использованием лучших практик.

## Рекомендуемые системные требования

- Python 3.12+
- Docker version 25+
- Docker Compose version v2+
- Poetry version 1.8+

Если версия Python более низкая, то можно установить локальную версию для конкретной директории через [pyenv](https://realpython.com/intro-to-pyenv/).

## Переименование проекта

Если не устраивает название модуля webapp, то проект можно переименовать:

1. Переименовать папку "`webapp`"
2. Заменить "`webapp`" в файле `/pyproject.toml`
3. Заменить "`webapp`" в файле `/.env`

## Запуск проекта

### Локальный запуск проекта

Устанавливаем Poetry (если не установлен):

```bash
pip install --upgrade pip
pip install poetry
```

В папке проекта создаем и активируем виртуальное окружение:

```bash
python -m venv venv
source venv/bin/activate
```

Собираем пакет с помощью Poetry:

```bash
poetry install
```

После установки пакета и зависимостей, запускаем Flask командой:

```bash
python -m webapp.app
```

Проект будет доступен по адресу: [localhost:5000](http://localhost:5000/).

### Запуск проекта с помощью Docker

Сборка и запуск проекта:

```bash
docker compose up -d
```

Проект будет доступен по адресу: [localhost:5000](http://localhost:5000/).

Остановка проекта (с отключением используемых томов):

```bash
docker compose down --volumes
```

#### Несколько полезных команд при работе с Docker

Просмотр списка зупущенных контейнеров:

```bash
docker ps
```

Подключение в контейнер:

```bash
docker exec -ti <container_id> sh
```

Тестирование compose.yml без запуска сборки (можно проверить переменные):

```bash
docker compose config
```

Удаление всех неиспользуемых в данных момент образов, контейнеров, томов, сетей и кэша сборок (осторожно, удаляются все неиспользуемые элементы):

```bash
docker system prune -a --volumes
```

## Возможные проблемы во время сборки проекта

Обратите внимание на особенности более старых версий docker-compose:

- Команда "docker compose" писалась через символ "минус" - docker-compose.
- Перед командой `up` нужно было запускать команду `build` (либо `docker-compose up -d --build`).
- В очень старых версиях docker-compose нужно было устанавливать отдельно от Docker.

Также может оказаться занятым порт `5001` - можно поменять до сборки в файле `compose.yml`.

## Добавление зависимостей в проект

В локальную сборку устанавливаем новые зависимости (пример):

```bash
poetry add flask-sqlalchemy
```

Пересобираем контейнер Docker (если используете).

## Краткое описание файловой системы проекта

```bash
$ tree flask-blank-project

flask-blank-project/
├── .dockerignore  # Файл исключений Docker (упомянутое не будет копироваться в контейнер при сборке командами ADD и COPY).
├── .gitignore  # Файл исключений Git.
├── .env  # Файл с переменными окружения для Docker Compose (самая важная переменная - `APPNAME=webapp` задается именно здесь).
├── README.md  # Файл документации проекта.
├── LICENSE  # Файл лицензии проекта (в данном случае MIT License).
├── compose.yml  # Файл настроек Docker Compose.
├── Dockerfile  # Файл настроек сборки Docker.
├── pyproject.toml  # Файл настроек сборки пакета Poetry.
├── poetry.lock  # Служебный файл Poetry (в проекте нужен для ускорения сборки).
├── data/  # Пустая папка для базы данных SQLite3 (сами файлы базы данных коммитить не нужно!).
    └── .gitkeep  # Трюк для Git (нужен для загрузки пустой директории в репозиторий).
├── tests/  # Папка для unit-тестов.
│   └── __init__.py
└── webapp/  # Папка основного пакета проекта.
    ├── __init__.py  # Служебный файл инициализации пакета Python.
    ├── __main__.py  # Служебный файл выполнения пакета Python. 
    ├── app.py  # Основной модуль пакета (запуск `python -m webapp.app`).
    ├── static  # Папка со статическими файлами (img, css, js и т.д.).
    │   └── style.css
    └── templates  # Папка с шаблонами (Flask использует шаблонизатор Jinja2).
        ├── 404.html
        ├── base.html
        ├── index.html
        └── page.html
```

Спасибо за внимание! :)
