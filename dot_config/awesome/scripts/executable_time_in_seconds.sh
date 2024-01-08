#!/usr/bin/env bash
# Tracks how long your system has been on today, outputs in seconds


# Converts a HH:MM:SS timestamp to seconds using awk
to_seconds() {
    awk -F: '{print $1 * 60 * 60 + $2 * 60 + $3}'
}

# Greps for the given timestamp and returns them as seconds
get_timestamps() {
    journalctl --since today | grep -P "$1" | awk '{print $3}' | to_seconds
}

mapfile -t boots < <(get_timestamps '(kernel: Linux version)|(suspend exit)')

mapfile -t poweroffs < <(get_timestamps '(systemd-logind.*?The system will)|(Suspending\.\.\.)')

# Check if we have a valid boot (we might not if the system has been on through midnight)
if [[ -z "${boots[0]}" ]] || [[ "${poweroffs[0]}" -lt "${boots[0]}" ]]; then
    # Add a dummy boot at midnight, we only care about *today*
    boots=( 0 "${boots[@]}" )
fi

# Add a fake poweroff at the end corresponding to the current time so that the maths are easier.
poweroffs+=("$(date +"%H:%M:%S" | to_seconds)")

# We need to make sure we have the same number of boots and poweroffs to be able to do the math
if (( "${#boots[@]}" != "${#poweroffs[@]}" )); then
    echo "ERROR: Wrong number of boot-poweroff events"
    exit 25
fi

total=0

for ((i = 0 ; i < "${#boots[@]}" ; i++ )); do
    total=$((total +  "${poweroffs[$i]}" - "${boots[$i]}"))
done

echo $total
