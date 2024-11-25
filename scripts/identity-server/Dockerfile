FROM quay.io/keycloak/keycloak:latest

COPY eshop-identity-realm.json /opt/keycloak/data/import/eshop-identity-realm.json

ENV KC_BOOTSTRAP_ADMIN_USERNAME=admin
ENV KC_BOOTSTRAP_ADMIN_PASSWORD=admin

CMD ["start-dev", "--import-realm"]
