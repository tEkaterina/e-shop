@echo off
SET CONTAINER_NAME=eshop-rabbitmq-container

docker start %CONTAINER_NAME% >nul 2>&1

IF %ERRORLEVEL% NEQ 0 (
    echo Container %CONTAINER_NAME% does not exist or cannot be started. Creating and starting container...
    docker run -d --hostname eshop-rabbitmq-host --name %CONTAINER_NAME% -p 5672:5672 -p 15672:15672 -e RABBITMQ_DEFAULT_USER=eshopuser -e RABBITMQ_DEFAULT_PASS=sKxX8nYq97FX rabbitmq:3-management
) ELSE (
    echo Container %CONTAINER_NAME% started successfully.
)
