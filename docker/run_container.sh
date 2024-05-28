#!/bin/bash

# Check if image name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <image-name>"
    exit 1
fi

# Get the image name from the first argument
image_name=$1

# Get the current user's details
current_user=$(whoami)
home_dir="/home/$current_user"
user_id=$(id -u)
group_id=$(id -g)
container_name="${current_user}_${image_name}_container"

# Run the Docker container with GPU support, IPC, and volume mount
docker run -d --name $container_name --gpus all --ipc=host \
    -v $home_dir:$home_dir \
    -w $home_dir \
    --user $user_id:$group_id \
    $image_name

