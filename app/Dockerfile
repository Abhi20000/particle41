# Use an official slim Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app


# Create a non-root user and group
RUN adduser --disabled-password --gecos "" abhishek

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the app code
COPY . .

# Change ownership of the app directory
RUN chown -R abhishek:abhishek /app

# Switch to non-root user
USER abhishek

# Expose the port Flask runs on
EXPOSE 5000

# Run the Flask app
CMD ["python", "simple_time_service.py"]
