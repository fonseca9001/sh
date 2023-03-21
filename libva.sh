#!/bin/bash

# Detect GPU vendor
gpu_vendor=$(lspci | grep -E "VGA|3D" | grep -E "Intel|NVIDIA" | head -n 1 | cut -d " " -f 5)

# Set LIBVA_DRIVER_NAME based on GPU vendor
if [ "$gpu_vendor" = "Intel" ]; then
    export LIBVA_DRIVER_NAME=iHD
elif [ "$gpu_vendor" = "NVIDIA" ]; then
    export LIBVA_DRIVER_NAME=nvidia
fi

# Check that LIBVA_DRIVER_NAME has been set
if [[ -z "${LIBVA_DRIVER_NAME}" ]]; then
    echo "Error: LIBVA_DRIVER_NAME not set" >> ~/libvaset.log
    exit 1
fi