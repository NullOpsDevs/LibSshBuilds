#!/bin/bash
set -e

PLATFORM=$1
TARGET_TRIPLE=$2
DOCKERFILE_PLATFORM=$3
DEBUG_LOGGING=${4:-OFF}

mkdir -p output

if [[ "$PLATFORM" == win-* ]]; then
  # Windows build using MinGW
  docker buildx build \
    --platform "$DOCKERFILE_PLATFORM" \
    --build-arg TARGET_TRIPLE="$TARGET_TRIPLE" \
    --build-arg DEBUG_LOGGING="$DEBUG_LOGGING" \
    --output type=local,dest=./output \
    -f .github/docker/windows.Dockerfile .

elif [[ "$PLATFORM" == osx-* ]]; then
  # macOS build using pre-built osxcross image
  docker buildx build \
    --platform "$DOCKERFILE_PLATFORM" \
    --build-arg TARGET_TRIPLE="$TARGET_TRIPLE" \
    --build-arg DEBUG_LOGGING="$DEBUG_LOGGING" \
    --output type=local,dest=./output \
    -f .github/docker/macos.Dockerfile .

else
  # Linux build
  docker buildx build \
    --platform "$DOCKERFILE_PLATFORM" \
    --build-arg DEBUG_LOGGING="$DEBUG_LOGGING" \
    --output type=local,dest=./output \
    -f .github/docker/linux.Dockerfile .
fi

# Create runtime directory structure
mkdir -p "runtimes/$PLATFORM/native"

# Copy libraries to correct location
if [[ "$PLATFORM" == win-* ]]; then
  cp output/libssh2.dll "runtimes/$PLATFORM/native/"
  cp output/libssh2.a "runtimes/$PLATFORM/native/" || cp output/libssh2.lib "runtimes/$PLATFORM/native/" || true
elif [[ "$PLATFORM" == osx-* ]]; then
  cp output/libssh2.dylib "runtimes/$PLATFORM/native/"
  cp output/libssh2.a "runtimes/$PLATFORM/native/" || true
else
  # Copy shared library and create symlink without version suffix
  cp output/libssh2.so* "runtimes/$PLATFORM/native/"
  # Copy static library
  cp output/libssh2.a "runtimes/$PLATFORM/native/" || true
  # Find the actual .so file and create a symlink
  cd "runtimes/$PLATFORM/native/"
  if [ -f libssh2.so.1 ]; then
    ln -sf libssh2.so.1 libssh2.so
  fi
fi
