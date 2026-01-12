
# Use the official OpenJDK base image
FROM eclipse-temurin:21

# Set the working directory inside the container
WORKDIR /app

# Copy the compiled Java application into the container
COPY dockerTest.class /app

# Run the Java application when the container starts
CMD ["java", "dockerTest"]