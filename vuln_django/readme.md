# Vulnerable Django

Setup Vuln App
```
pip3 install django
python3 manage.py migrate  
python manage.py runserver
```

or build and via docker
```bash
docker build -t vuln-django .
docker run -p 8000:8000 vuln-django
```

now test the vulnerable endpoints

**code injection**
```bash
http://127.0.0.1:8000/vulnerable-app/code-injection/?code=2+2
```

**sql injection**
```bash
http://127.0.0.1:8000/vulnerable-app/sql-injection/?query=SELECT * FROM django_migrations;
```