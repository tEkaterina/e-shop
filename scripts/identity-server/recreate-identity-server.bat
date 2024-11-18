@echo off
SET IMAGE_NAME=eshop-keycloack-identity-server
SET CONTAINER_NAME=eshop-identity-server

docker inspect --format="{{.State.Running}}" %CONTAINER_NAME% >nul 2>&1

IF %ERRORLEVEL% EQU 0 (
    docker stop %CONTAINER_NAME%
    docker rm %CONTAINER_NAME%
)

docker image inspect %IMAGE_NAME% >nul 2>&1

IF %ERRORLEVEL% EQU 0 (
    docker rmi %IMAGE_NAME%
)

call run-identity-server.bat
