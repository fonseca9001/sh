#!/bin/bash

# Set error handling
set -e

# Check if glxinfo is installed
command -v glxinfo >/dev/null 2>&1 || { echo >&2 "glxinfo is required but not installed. Aborting."; exit 1; }

# Get GPU vendor
gpu_vendor=$(glxinfo | grep -m 1 -E -i "OpenGL vendor|OpenGL renderer string" | awk '{if (tolower($0) ~ /intel/) print "Intel"; else if (tolower($0) ~ /nvidia/) print "NVIDIA"}')

# Set LIBVA_DRIVER_NAME based on GPU vendor
case $gpu_vendor in
    Intel)
        export LIBVA_DRIVER_NAME=iHD
        ;;
    NVIDIA)
        export LIBVA_DRIVER_NAME=nvidia
        ;;
    *)
        echo "Unsupported GPU vendor: $gpu_vendor"
        exit 1
        ;;
esac
