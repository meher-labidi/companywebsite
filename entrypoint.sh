#!/bin/sh

set -e

echo "Waiting for database..."
sleep 3

echo "Running migrations..."
python manage.py migrate --noinput

echo "Collecting static files..."
python manage.py collectstatic --noinput

echo "Creating superuser if it doesn't exist..."
python manage.py shell << 'EOF'
from django.contrib.auth import get_user_model
User = get_user_model()
import os
username = os.environ.get('DJANGO_SUPERUSER_USERNAME', 'admin')
email    = os.environ.get('DJANGO_SUPERUSER_EMAIL', 'admin@example.com')
password = os.environ.get('DJANGO_SUPERUSER_PASSWORD', 'admin1234')
if not User.objects.filter(username=username).exists():
    User.objects.create_superuser(username=username, email=email, password=password)
    print(f"Superuser '{username}' created.")
else:
    print(f"Superuser '{username}' already exists.")
EOF

echo "Starting Gunicorn..."
exec gunicorn config.wsgi:application \
    --bind 0.0.0.0:8000 \
    --workers 3 \
    --timeout 120 \
    --access-logfile - \
    --error-logfile -
```

---

## 4. `.dockerignore`
```
.git
__pycache__
*.pyc
*.pyo
venv/
env/
.env
*.sqlite3
db.sqlite3
staticfiles/
media/
.vscode/
.idea/
*.log
.DS_Store
```

---

## 5. `.env`
```
SECRET_KEY=your-very-secret-key-change-this
DEBUG=False
ALLOWED_HOSTS=localhost,127.0.0.1

POSTGRES_DB=controlpro_db
POSTGRES_USER=controlpro_user
POSTGRES_PASSWORD=StrongPassword123
DATABASE_URL=postgres://controlpro_user:StrongPassword123@db:5432/controlpro_db

EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=abidim283@gmail.com
EMAIL_HOST_PASSWORD=xxpj whxd idgl zqpz
DEFAULT_FROM_EMAIL=abidim283@gmail.com
NOTIFY_EMAIL=abidim283@gmail.com

DJANGO_SUPERUSER_USERNAME=admin
DJANGO_SUPERUSER_EMAIL=admin@example.com
DJANGO_SUPERUSER_PASSWORD=Admin1234!