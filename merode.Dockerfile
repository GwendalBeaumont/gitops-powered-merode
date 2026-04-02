FROM gradle:8-jdk21-alpine AS build
WORKDIR /usr/app/
COPY merode-interpreter-api .
RUN gradle installDist

FROM eclipse-temurin:21-alpine
ENV APP_HOME=/usr/app
WORKDIR $APP_HOME
COPY --from=build $APP_HOME/build/install/merode .
COPY ./model/model.mxp .
EXPOSE 8080
CMD ["./bin/merode", "-m", "model.mxp"]
