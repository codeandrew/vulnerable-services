# Vulnerable Dotnet App

## Creation

dotnet new webapi -n VulnerableDotNetApp

## Endpoints

- http://{baseUrl}/Vulnerable/SqlInjection?args
controler/method

VulnerableDotNetApp/Controllers/VulnerableController.cs
```c#
...
namespace VulnerableApp.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    ...
```

then the endpoints will be 

## NUGET

sudo apt update
sudo apt install mono-complete


## DOTNET PACKAGE MANAGER

dotnet add package Microsoft.Data.Sqlite

## Steps

**DEVELOPMENT**
- dotnet add package $PACKAGE_NAME
- dotnet restore

**CICD**
- dotnet restore # download all packages/reference in *.csproj 
- dotnet build # compile 
- dotnet run # runs ./bin/*.dll file 



## Package Manager

sln for multiple projects
*.csproj for one project



## Commands 

dotnet sln = for creating solution
dotnet new = for creating webapi
dotnet add = for adding csproj to solution

https://learn.microsoft.com/en-us/dotnet/core/tools/

https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-sln