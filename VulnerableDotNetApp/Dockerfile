# Use the official image as a parent image
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80

# Use SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["VulnerableDotNetApp.csproj", "./"]
RUN dotnet restore "VulnerableDotNetApp.csproj"
COPY . .
RUN dotnet build "VulnerableDotNetApp.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "VulnerableDotNetApp.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "VulnerableDotNetApp.dll"]
