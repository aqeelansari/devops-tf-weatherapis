# Get Base Image (Full .NET Core SDK)
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copy csproj and restore
COPY weatherapis.csproj .
RUN dotnet restore

# Copy everything else and build
COPY . .
RUN dotnet publish -c release -o /app

# Generate runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
EXPOSE 80
COPY --from=build /app .
ENTRYPOINT ["dotnet", "weatherapis.dll"]