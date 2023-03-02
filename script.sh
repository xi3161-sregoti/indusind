#!/bin/bash

# Load the original YAML file
original_yaml=$(cat current.yaml)

# Perform the CI operation here

# Load the updated YAML file
updated_yaml=$(cat updated.yaml)

# Extract the 2nd level field names from the YAML file
field_names=$(echo "$original_yaml" | yq eval '.app | keys | .[]' -)


# Loop over the field names and compare the values in the original and updated YAML files
for field_name in $field_names; do
  original_value=$(echo "$original_yaml" | yq eval ".app.$field_name" -)
  updated_value=$(echo "$updated_yaml" | yq eval ".app.$field_name" -)

  if [[ "$original_value" != "$updated_value" ]]; then
    echo "$field_name"
  fi
done