#!/bin/bash

# getJobList_SLURMerr.sh bash script
# AUTHORS:
# Jeremy Simmons (email: simmo536@umn.edu)
# University of Minnesota
# Department of Mechanical Engineering
#
# CREATION DATE:
# 12Aug2024
#
# PURPOSE/DESCRIPTION:
# Application: SLURM job arrays
#
# This bash script searches the current directory for non-empty .err files and
# gives a comma seperated list of the file's task ID. This analysis assumes
# that the naming convention of the .err files is %A_%a.err, where %A is the
# SLURM_ARRAY_JOB_ID and %a is the SLURM_ARRAY_TASK_ID.
#
# FILE DEPENDENCY:
# N/A
#
# UPDATES:
# 12Aug2024 - Created.
#
# Copyright (C) 2024  Jeremy W. Simmons II
# 
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
# 
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
# 
#   You should have received a copy of the GNU General Public License
#   along with this program. If not, see <https://www.gnu.org/licenses/>.
#
## %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# Directory path where your files are located
directory_path="."

# List to store nonempty indices
nonempty_indices=()

# Iterate through "*.err" files in the directory
for filename in "$directory_path"/*.err; do
    # Check if the file is nonempty
    if [ -s "$filename" ]; then
        # Extract the second set of numbers using grep and sed
        index=$(echo "$filename" | grep -oE '_([0-9]+)\.err' | sed -n 's/_\([0-9]\+\)\.err/\1/p')
        nonempty_indices+=("$index")
    fi
done

# Create a comma-separated string from the array
result=$(IFS=,; echo "${nonempty_indices[*]}")

# Print or use the result as needed
echo "$result"

