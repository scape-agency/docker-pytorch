# syntax=docker/dockerfile:1.4


# Base Image
# =============================================================================

# Use the official PyTorch image from NVIDIA as a base image
FROM pytorch/pytorch:2.3.1-cuda12.1-cudnn8-runtime






# System Dependencies
# =============================================================================

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    wget \
    # ffmpeg \
    # libsm6 \
    # libxext6 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


# Python Dependencies
# =============================================================================

# Install Python dependencies
# RUN pip install --no-cache-dir -r requirements.txt
COPY requirements.txt /tmp/
RUN pip install --requirement /tmp/requirements.txt

# Install
# =============================================================================

# Install any needed packages specified in requirements.txt





# Entrypoint
# =============================================================================

# Run the application
CMD ["python", "./src/my_script.py"]