#!/bin/bash

# Set error handling
set -e

# Set log file path
LOG_FILE="$HOME/libvaset.log"

# Check if glxinfo is installed
if ! command -v glxinfo >/dev/null 2>&1; then
    echo "glxinfo is required but not installed. Aborting." >> "$LOG_FILE"
    exit 1
fi

# Get GPU vendor
gpu_vendor=$(glxinfo | grep -m 1 -E -i "OpenGL vendor|OpenGL renderer string" | awk '{if (tolower($0) ~ /intel/) print "Intel"; else if (tolower($0) ~ /nvidia/) print "NVIDIA"}')

# Set LIBVA_DRIVER_NAME and VDPAU_DRIVER based on GPU vendor
case $gpu_vendor in
    Intel)
        export LIBVA_DRIVER_NAME=iHD &&
        export VDPAU_DRIVER=va_gl
        ;;
    NVIDIA)
        export LIBVA_DRIVER_NAME=nvidia &&
        export VDPAU_DRIVER=nvidia
        ;;
    *)
        echo "Unsupported GPU vendor: $gpu_vendor" >> "$LOG_FILE"
        exit 1
        ;;
esac

exit 0
