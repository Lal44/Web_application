# Step 1: Build the Maven project
FROM maven:3.8.1-openjdk-11 AS build
WORKDIR /app

# Copy the project files
COPY . .

# Run Maven build to package the web app
RUN mvn clean package

# Step 2: Use Tomcat to deploy the WAR
FROM tomcat:9.0-jdk11

# Copy the WAR file from the build stage to the Tomcat webapps folder
COPY --from=build /app/target/my-webapp.war /usr/local/tomcat/webapps/

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
