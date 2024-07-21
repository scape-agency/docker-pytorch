#!/bin/bash

# Define the image name
IMAGE_NAME="pytorch"

# Step to build the Docker image
echo "Building Docker image..."
docker build -t $IMAGE_NAME .

# Check if build was successful
if [ $? -ne 0 ]; then
  echo "Docker build failed."
  exit 1
fi

echo "Docker image built successfully."

# Asking if GPU support is needed
read -p "Do you want to run with GPU support? (y/n): " USE_GPU

# Run options based on GPU support
if [[ "$USE_GPU" =~ ^[Yy]$ ]]
then
  docker run -it --rm --gpus all $IMAGE_NAME
else
  docker run -it --rm $IMAGE_NAME
fi
