
docker build -t vuln-dotnet .
docker run -p 5000:80 vuln-dotnet