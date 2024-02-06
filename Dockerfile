FROM postgres:12.17-bullseye
ENV POSTGRES_PASSWORD POSTGRES_PASSWORD
ENV POSTGRES_DB athletix-back
COPY ath.sql /docker-entrypoint-initdb.d/