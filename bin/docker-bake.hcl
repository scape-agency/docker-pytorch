# Copyright 2024 Scape Agency BV. All rights reserved.

# Description:
# This script defines variables and targets for building and releasing Docker images.


# Variables
# =============================================================================

variable "REGISTRY_ENDPOINT" {
  description = "The endpoint URL for the Docker registry."
  default = "unknown"
}

variable "REPOSITORY_ENDPOINT" {
  description = "The endpoint URL for the Docker repository."
  default = "unknown"
}

variable "IMAGE_NAME" {
  description = "The name of the Docker image."
  default = "unknown"
}

variable "BRANCH" {
  description = "The current branch name used in the build process."
  default = "main"
}

variable "VERSION" {
  description = "The version tag for the Docker image."
  default = "unknown"
}


# Targets
# =============================================================================

# Build the Docker image
target "image" {
  description = "Builds the Docker image from the Dockerfile located in the specified context directory."
  context = "./src/${IMAGE_NAME}/"
  dockerfile = "Dockerfile"
  // Optionally specify a build target (uncomment to enable)
  // target = "runner"
  tags = [
    "${REGISTRY_ENDPOINT}/${IMAGE_NAME}:${VERSION}",
    "${REGISTRY_ENDPOINT}/${IMAGE_NAME}:latest",
    "${REPOSITORY_ENDPOINT}/${IMAGE_NAME}:${VERSION}",
    "${REPOSITORY_ENDPOINT}/${IMAGE_NAME}:latest",
  ]
}

# -----------------------------------------------------------------------------

# Advanced build settings for release
target "_release" {
  args = {
    BUILDKIT_CONTEXT_KEEP_GIT_DIR = 1
    BUILDX_EXPERIMENTAL = 0
  }
}

# Build the image across all platforms
target "image-all" {
  inherits = ["image", "_release"]
  platforms = ["linux/amd64", "linux/arm64"]
  output = ["type=registry"]
}


# Groups
# =============================================================================

# Default group
group "default" {
  targets = [
    "image-all"
  ]
} 
