@echo off
echo Starting keycloak and rabbitmq...

call ./scripts/start-rabbitmq.bat

pushd "./scripts/identity-server"
call run-identity-server.bat
popd

echo Building applications...

dotnet build "./CartService/CartService.csproj"
dotnet build "./CatalogService/CatalogService.Web/CatalogService.Web.csproj"

echo Running applications...

start /b cmd /c dotnet run --project "./CartService/CartService.csproj"
start /b cmd /c dotnet run --project "./CatalogService/CatalogService.Web/CatalogService.Web.csproj"

echo All applications and resources have been started.
