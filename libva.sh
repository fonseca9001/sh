#!/bin/bash

# Detect GPU vendor
gpu_vendor=$(glxinfo | grep -m 1 -E -i "OpenGL vendor|OpenGL renderer string" | awk '{if (tolower($0) ~ /intel/) print "Intel"; else if (tolower($0) ~ /nvidia/) print "NVIDIA"}')
# Set LIBVA_DRIVER_NAME based on GPU vendor
if [ "$gpu_vendor" = "Intel" ]; then
    export LIBVA_DRIVER_NAME=iHD && export VDPAU_DRIVER=va_gl
elif [ "$gpu_vendor" = "NVIDIA" ]; then
    export LIBVA_DRIVER_NAME=nvidia && export VDPAU_DRIVER=nvidia
fi
