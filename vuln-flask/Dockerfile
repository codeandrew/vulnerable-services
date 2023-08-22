FROM python:3.11-slim

WORKDIR /app

COPY . /app

# RUN pip install --trusted-host pypi.python.org flask
RUN pip install -r requirements.txt

EXPOSE 5000

CMD ["python", "app.py"]
# docker build -t vuln-flask .