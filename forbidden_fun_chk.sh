#!/bin/bash

# Parse command-line options
while [ $# -gt 0 ]; do
    case "$1" in
        -i)
            if [ $# -gt 1 ] && [ "${2:0:1}" != "-" ]; then
                input_file="$2"
                shift 2
            else
                input_file="allowed_fun.txt"
                shift
            fi
            ;;
        -o)
            if [ $# -gt 1 ] && [ "${2:0:1}" != "-" ]; then
                output_file="$2"
                shift 2
            else
                output_file="forbidden_fun.txt"
                shift
            fi
            ;;
        *)
            file_to_test="$1"
            shift
            break
            ;;
    esac
done

# Check if file_to_test is provided
if [ -z "$file_to_test" ]; then
    echo "Usage: $0 [-i [input_file]] [-o [output_file]] file_to_test"
    exit 1
fi

# Read allowed functions
if [ -n "$input_file" ]; then
    mapfile -t allowed_funcs < "$input_file"
else
    mapfile -t allowed_funcs
fi

# Extract undefined symbols, exclude those starting with '_', and remove everything after '@'
mapfile -t found_funcs < <(nm -u "$file_to_test" | awk '{print $2}' | grep -v '^_' | sed 's/@.*//')

# Compute forbidden functions (found but not allowed)
mapfile -t forbidden_funcs < <(comm -23 <(printf '%s\n' "${found_funcs[@]}" | sort) <(printf '%s\n' "${allowed_funcs[@]}" | sort))

# Print results to stdout
echo "ALLOWED FUNCTIONS:"
printf '%s\n' "${allowed_funcs[@]}"
echo ""

echo "FOUND FUNCTIONS:"
printf '%s\n' "${found_funcs[@]}"
echo ""

echo "FORBIDDEN FUNCTIONS:"
printf '%s\n' "${forbidden_funcs[@]}"
echo ""

# Write forbidden functions to output file if -o is specified
if [ -n "$output_file" ]; then
    printf '%s\n' "${forbidden_funcs[@]}" > "$output_file"
fi
