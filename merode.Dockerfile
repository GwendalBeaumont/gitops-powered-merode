FROM gradle:8-jdk21-alpine AS build
WORKDIR /usr/app/
COPY merode-interpreter-api .
RUN gradle installDist

FROM eclipse-temurin:21-alpine
ENV APP_HOME=/usr/app
COPY --from=build $APP_HOME/build/install/merode .
CMD mkdir -p data
EXPOSE 8080
ENTRYPOINT ["./bin/merode"]
CMD ["-m", "data/model.mxp"]
