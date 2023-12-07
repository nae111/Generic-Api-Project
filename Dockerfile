# Указывает базовый образ для создания контейнера.
# В данном случае используется Python версии 3.10
FROM python:3.10-slim

# Открывает порт 8000 в контейнере. Это необходимо для того, чтобы внешние приложения могли
# обращаться к вашему DJango прибложению через этот порт.
EXPOSE 8000

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Устанавливает виртуальное окружение для Python чтобы гарантировать, что вывод Python будет
# отправляться прямо в терминал без буферизации.
ENV PYTHONUNBUFFERED=1

# Устанавливает зависимости перечисленные в файле requirements.txt,
# используя инструмент управления пакетами pip
COPY requirements.txt .
RUN python -m pip install -r requirements.txt

# Устанавливает рабочую директорию внутри контейнера.
# Все последующие команды будут выполняться в этой директории.
WORKDIR /app

# Копирует все файлы проекта из локальной директории внешнего проекта внутрь контейнера в директорию /app/
COPY . /app

# Создает пользователя без прав root с явным UID и добавляет разрешение на доступ к папкее /app
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

# Запускаем сервер Django при старте контейнера
CMD ["python","manage.py","runserver", "127.0.0.1:8000" ]
