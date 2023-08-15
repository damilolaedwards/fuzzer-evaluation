#!/bin/bash

# Loop through mutant numbers 01 to 06
for mutant_num in {01..12}; do
    # Construct the command and execute it
    cmd="make evaluate seed=1 mutant=$mutant_num"
    echo "Running: $cmd"
    $cmd
done

sleep 90

sudo shutdown -h now