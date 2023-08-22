# Vulnerable Flask

quick run
```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python app.py
```

Run by Docker 
```bash
docker build -t vuln-flask .
docker run -p 5000:5000 vuln-flask
```

Deploy in Kubernetes/Minikube
```bash
kubectl apply -f vuln-flask-deployment.yaml
kubectl apply -f vuln-flask-service.yaml
```
