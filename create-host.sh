#!/bin/bash

echo "---"
printf "all:\n"
printf "  hosts:\n"
printf "    remote:\n"
printf "      ansible_connection: ssh\n"
printf "      ansible_user: ubuntu\n"
printf "      ansible_port: 22\n"
printf "      ansible_host: %s\n" "$1"
