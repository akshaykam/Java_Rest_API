# Use OpenJDK 17 as the base image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the Maven wrapper (if available) and the pom.xml
COPY . /app/

# Install Maven (in case it's not included)
RUN yum update && yum install -y maven

# Run Maven to build the project and generate the jar file
RUN mvn clean package -DskipTests

# Expose the port the app will run on (adjust if needed)
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "target/restapidemo-0.0.1-SNAPSHOT.jar"]
