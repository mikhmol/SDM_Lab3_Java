# Base image with JDK 17
FROM openjdk:17-jdk-slim

# Application directory inside Docker image
WORKDIR /app

# Copy maven executable to the image
COPY mvnw .
COPY .mvn .mvn

# Copy the pom.xml file to download dependencies
COPY pom.xml .

# Download dependencies
RUN ./mvnw dependency:go-offline -B

# Copy other project files and build the project
COPY src src

RUN ./mvnw package -DskipTests

# Entry point to start the Spring Boot application
ENTRYPOINT ["java","-jar","target/demo-0.0.1-SNAPSHOT.jar"]

# Expose the application on port 8080
EXPOSE 8080
