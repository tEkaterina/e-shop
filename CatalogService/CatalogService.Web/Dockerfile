# See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

# This stage is used when running from VS in fast mode (Default for Debug configuration)
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
USER app
WORKDIR /app
EXPOSE 8080
EXPOSE 8081


# This stage is used to build the service project
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["Directory.Build.targets", "."]
COPY ["CatalogService/CatalogService.Web/CatalogService.Web.csproj", "CatalogService/CatalogService.Web/"]
COPY ["EShop.MessageBrokerClient/EShop.MessageBrokerClient.csproj", "EShop.MessageBrokerClient/"]
COPY ["CatalogService/CatalogService.Application/CatalogService.Application.csproj", "CatalogService/CatalogService.Application/"]
COPY ["CatalogService/CatalogService.Domain/CatalogService.Domain.csproj", "CatalogService/CatalogService.Domain/"]
COPY ["CatalogService/CatalogService.Infrastructure/CatalogService.Infrastructure.csproj", "CatalogService/CatalogService.Infrastructure/"]
RUN dotnet restore "./CatalogService/CatalogService.Web/CatalogService.Web.csproj"
COPY . .
WORKDIR "/src/CatalogService/CatalogService.Web"
RUN dotnet build "./CatalogService.Web.csproj" -c $BUILD_CONFIGURATION -o /app/build

# This stage is used to publish the service project to be copied to the final stage
FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./CatalogService.Web.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

# This stage is used in production or when running from VS in regular mode (Default when not using the Debug configuration)
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "CatalogService.Web.dll"]