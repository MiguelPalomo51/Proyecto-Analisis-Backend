FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/ProyectoAnalisisSistemas-0.0.1-SNAPSHOT.jar app.jar

ENV DB_HOST=ls-f5d171b3d45e9d98f9db20ef73822ebcaf424276.c9wswwa2w4rc.us-east-1.rds.amazonaws.com
ENV DB_PORT=5432
ENV DB_NAME=seguridad_db
ENV DB_USER=analisis
ENV DB_PASSWORD=analisis123$
ENV SPRING_JPA_HIBERNATE_DDL_AUTO=update

EXPOSE 8080

ENTRYPOINT ["java", "-Dspring.profiles.active=prod", "-jar", "app.jar"]