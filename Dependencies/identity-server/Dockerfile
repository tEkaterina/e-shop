FROM quay.io/keycloak/keycloak:latest

COPY ./Dependencies/identity-server/eshop-identity-realm.json /opt/keycloak/data/import/eshop-identity-realm.json

CMD ["start-dev", "--import-realm"]
