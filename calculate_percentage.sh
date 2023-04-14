#!/bin/bash

# Function to convert size strings to gigabytes
function to_gb {
  local size="$1"
  local unit="${size:(-1)}"
  local value="${size:0:${#size}-1}"
  if [ "${#size}" -eq 1 ]; then
    value="$size"
    unit=""
  fi
  case "$unit" in
    "K") echo "scale=10; $value / 1000000000" | bc 2>/dev/null ;;
    "M") echo "scale=10; $value / 1000" | bc 2>/dev/null ;;
    "G") echo "${value}" ;;
    "T") echo "scale=10; $value * 1000" | bc 2>/dev/null ;;
    "P") echo "scale=10; $value * 1000000" | bc 2>/dev/null ;;
  esac
}

# Parse input and calculate percentages
# If a bucket is empty it will not show up
tmp_file=$(mktemp)
echo $(s3cmd du -H) | sed 's/\/ /\n/g;s/------------ /&\n/' > "$tmp_file"

os_size="250"

while read -r size _ bucket; do
  gb="$(to_gb "$size")"
  percent="$(echo "scale=4; ($gb / $os_size) * 100" | bc 2>/dev/null)"
  if [ $? -eq 0 ]; then
    echo "Bucket $bucket: $percent% : $size / $os_size"G""
  else
    exit 1
  fi
done < "$tmp_file"

rm "$tmp_file"

