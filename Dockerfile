# Stage 1: Build stage
FROM maven:3.8 AS build

# Set the working directory for the build
WORKDIR /app

# Copy the Maven project files and the source code
COPY pom.xml /app/
COPY src /app/src/

# Run Maven to build the project and generate the jar file
RUN mvn clean package -DskipTests

# Stage 2: Runtime stage (smaller base image)
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy only the built JAR file from the build stage
COPY --from=build /app/target/restapidemo-0.0.1-SNAPSHOT.jar /app/restapidemo.jar

# Expose the port the app will run on (adjust if needed)
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "restapidemo.jar"]
