# syntax=docker/dockerfile:1.4

# Base Image
# =============================================================================

# Use Ubuntu 24.04 as the base image
FROM ubuntu:24.04

# System Dependencies
# =============================================================================

# Avoid prompts during package installation
ARG DEBIAN_FRONTEND=noninteractive

# Install system dependencies required for the project
# Update and install system dependencies in one layer
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    python3-pip \
    python3-dev \
    # python3-full \
    python3-venv \
    build-essential \
    && apt-get clean \
    # Clean up to reduce image size
    && rm -rf /var/lib/apt/lists/*


# Python Dependencies
# =============================================================================

# Create a virtual environment
RUN python3 -m venv /opt/venv

# Set environment variable to use the virtual environment
ENV PATH="/opt/venv/bin:$PATH"

# Link python3 to python for compatibility
RUN ln -s /usr/bin/python3 /usr/bin/python

# Upgrade pip and install Poetry in one layer to avoid intermediate issues
RUN \
    # Upgrade pip to its latest version
    pip3 install --upgrade pip && \
    # Ensure setuptools is up-to-date
    pip3 install --upgrade setuptools && \
    # Ensure wheel is up-to-date
    pip3 install --upgrade wheel && \
    # Install Poetry - a dependency manager for Python
    pip3 install poetry && \
    # Install PyTorch with CUDA support
    pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113





# Copy the requirements file and install Python dependencies
COPY ./etc/requirements.txt /tmp/
RUN pip3 install -r /tmp/requirements.txt

# Set the working directory
WORKDIR /app

# Copy the rest of your application's code
COPY . /app

# Command to run on container start
CMD ["python", "app.py"]
