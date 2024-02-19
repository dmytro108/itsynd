# Use an official Python runtime as a parent image
FROM python:3.9-slim-buster

# Create a non-root user and switch to it
RUN useradd --create-home appuser
USER appuser

# Set the working directory in the container to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY --chown=appuser:appuser . /app

# Run the command python ./your-script.py when the container launches
CMD ["python", "./logging-app.py"]