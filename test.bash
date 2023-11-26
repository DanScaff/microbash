#!/bin/bash

assert() {


    if [ "$1" != "$2" ]; then
        echo "Assert failed for command: $3"
        echo "Expected: '$1', but got: '$2'"
        exit 1
    fi
    if [ "$1" = "$2" ]; then
        echo "Assert passed for command: $3"
    fi
}


MICROBASH_PATH="./microbash"


TEST_FILE_PATH="./test_commands.txt"

while IFS= read -r command; do
    echo "Testing command: $command"


    output_bash=$(bash -c "$command")


    output_microbash=$($MICROBASH_PATH <<< "$command" | sed 's/^.*$ //')


    assert "$output_bash" "$output_microbash" "$command"
    echo "-------------------------"
done < "$TEST_FILE_PATH"
