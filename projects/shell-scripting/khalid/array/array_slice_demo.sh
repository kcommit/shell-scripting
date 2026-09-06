#!/bin/bash

data_folder="${1:-}"

items=("$data_folder"/*)

echo "${items[@]}"

echo "${items[@]}" | wc -l

printf '%s\n' "${items[@]}"

printf '%s\n' "${items[@]}" | wc -l


echo "${items[2]}"

echo "${#items[@]}"

printf '%s\n' "${items[@]:1:3}"

slice=($(printf '%s\n' "${items[@]:1:3}"))

echo "$slice"
