FROM gradle:jdk21-alpine AS BUILD
WORKDIR /usr/app/
COPY merode-interpreter-api .
RUN ./gradlew installDist

FROM eclipse-temurin:21-alpine
ENV APP_HOME=/usr/app
WORKDIR $APP_HOME
COPY --from=BUILD $APP_HOME/build/install/merode .
COPY ./model/model.mxp .
EXPOSE 8080
CMD ["./bin/merode", "-m", "model.mxp"]
