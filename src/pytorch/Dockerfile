# syntax=docker/dockerfile:1.4


# Base Image
# =============================================================================

# Use the official PyTorch image from NVIDIA as a base image
# FROM pytorch/pytorch:2.3.1-cuda12.1-cudnn8-runtime
# Use an Ubuntu base image
FROM ubuntu:24.04


# System Dependencies
# =============================================================================

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
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    python3-pip \
    python3-dev \
    build-essential \
    # Clean up to reduce image size
    && rm -rf /var/lib/apt/lists/*



# Python Dependencies
# =============================================================================

# Link python3 to python for compatibility
RUN ln -s /usr/bin/python3 /usr/bin/python

# Upgrade pip to its latest version
RUN pip3 install --upgrade pip

# Install Poetry - a dependency manager for Python
RUN pip3 install poetry

# Configure poetry:
# Disable virtualenv creation inside the Docker environment
# This is because Docker already provides an isolated environment
ENV POETRY_HOME=/etc/poetry \
    PATH="$POETRY_HOME/bin:$PATH" \
    POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_CREATE=false



# Install PyTorch with CUDA support
# RUN pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113

# Copy the requirements file and install Python dependencies
# COPY etc/requirements.txt /tmp/
# RUN pip3 install -r /tmp/requirements.txt


# Install
# =============================================================================

# Set the working directory to /app
WORKDIR /app

# Copy only the pyproject.toml and poetry.lock* files to use cache effectively
COPY etc/pyproject.toml etc/poetry.lock* /app/

# Install dependencies specified in Poetry configuration without installing the package itself
RUN poetry install --no-root --no-dev

# Copy the rest of your application's code into the container
# COPY . /app



# Entrypoint
# =============================================================================

# Command to run on container start
CMD ["python", "app.py"]