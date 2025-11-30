FROM mysql:latest
WORKDIR /
COPY ./scripts/script_atualizado.sql /docker-entrypoint-initdb.d/
EXPOSE 3306