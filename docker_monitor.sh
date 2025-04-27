#!/bin/bash

# Infinite loop to run the command every 2 seconds
while true; do
    # Place your command here, for example:
    echo "Running monitor at $(date)"

    docker ps

    # Sleep for 2 seconds before repeating
    sleep 2
    clear
done
