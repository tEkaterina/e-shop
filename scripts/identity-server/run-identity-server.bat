@echo off

SET IMAGE_NAME=eshop-keycloack-identity-server
SET CONTAINER_NAME=eshop-identity-server

echo Checking if image %IMAGE_NAME% exists...

docker image inspect %IMAGE_NAME% >nul 2>&1

IF %ERRORLEVEL% EQU 1 (
    echo Image does not exist. Building image...
    docker build -t %IMAGE_NAME% .
) ELSE (
    echo Image already exists.
)

echo Checking if container %CONTAINER_NAME% is running...
docker inspect --format="{{.State.Running}}" %CONTAINER_NAME% >nul 2>&1

IF %ERRORLEVEL% EQU 1 (
    echo Container is not running. Running container...
    docker run -d -p 8080:8080 --name %CONTAINER_NAME% %IMAGE_NAME%
) ELSE (
    echo Container is already running.
)

pause