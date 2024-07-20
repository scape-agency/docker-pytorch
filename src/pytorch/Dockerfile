# syntax=docker/dockerfile:1.4


# Base Image
# =============================================================================

# Use the official PyTorch image from NVIDIA as a base image
# FROM pytorch/pytorch:2.3.1-cuda12.1-cudnn8-runtime
# Use an Ubuntu base image
FROM ubuntu:20.04


# System Dependencies
# =============================================================================

# Avoid prompts during package installation
ARG DEBIAN_FRONTEND=noninteractive

# Install basic utilities
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    python3-pip \
    python3-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*


# Python Dependencies
# =============================================================================

# Link python3 to python
RUN ln -s /usr/bin/python3 /usr/bin/python

# Upgrade pip
RUN pip3 install --upgrade pip

# Install Poetry
RUN pip3 install poetry

# Set poetry environment variables (not to create virtual environments)
ENV POETRY_HOME=/etc/poetry
ENV PATH="$POETRY_HOME/bin:$PATH"
ENV POETRY_NO_INTERACTION=1
ENV POETRY_VIRTUALENVS_CREATE=false


# Install PyTorch with CUDA support
# RUN pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113

# Copy the requirements file and install Python dependencies
# COPY etc/requirements.txt /tmp/
# RUN pip3 install -r /tmp/requirements.txt


# Install
# =============================================================================

# Set the working directory
WORKDIR /app

# Copy the pyproject.toml and optionally poetry.lock file
COPY pyproject.toml poetry.lock* /app/

# Install dependencies using poetry
RUN poetry install --no-root --no-dev

# Copy the rest of your application's code
COPY . /app





# Entrypoint
# =============================================================================

# Command to run on container start
CMD ["python", "app.py"]