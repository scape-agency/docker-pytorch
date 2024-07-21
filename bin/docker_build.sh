#!/bin/bash

# Function to print current time and log message
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Function to build Docker image
build_image() {
  local image_name=$1
  local image_tag=$2
  local dockerfile_path=$3

  # Extract the directory path from the full Dockerfile path
  local context_dir=$(dirname "$dockerfile_path")

  # Check if Dockerfile exists at the specified path
  if [ ! -f "$dockerfile_path" ]; then
    log "ERROR: Dockerfile does not exist at specified path: $dockerfile_path"
    exit 1
  fi

  log "Building Docker image $image_name:$image_tag using Dockerfile at $dockerfile_path with context $context_dir..."
  docker build -f "$dockerfile_path" -t "$image_name:$image_tag" "$context_dir"

  # Check if build was successful
  if [ $? -ne 0 ]; then
    log "Docker build failed."
    exit 1
  fi

  log "Docker image built successfully."
}

# Default image name, tag, and Dockerfile path
DEFAULT_IMAGE_NAME="pytorch"
DEFAULT_TAG="latest"
DEFAULT_DOCKERFILE_PATH="../src/pytorch/Dockerfile"

# Command line arguments for image name, tag, and Dockerfile path
IMAGE_NAME=${1:-$DEFAULT_IMAGE_NAME}
TAG=${2:-$DEFAULT_TAG}
DOCKERFILE_PATH=${3:-$DEFAULT_DOCKERFILE_PATH}

# Main execution
build_image $IMAGE_NAME $TAG $DOCKERFILE_PATH
