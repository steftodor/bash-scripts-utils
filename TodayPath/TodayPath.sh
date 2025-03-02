#!/bin/bash
USER_NAME=$(whoami)
ALT_USER=""
DAYS_OFFSET=0
BASE_PATH="/path/to/location"

while getopts "u:d:" opt; do
  case ${opt} in
    u ) ALT_USER=$OPTARG ;; 
    d ) DAYS_OFFSET=$OPTARG ;;
    * ) echo "Usage: $0 [-u alternative_user] [-d days_offset]"; exit 1 ;;
  esac
done

# Get ALT USERNAME
if [[ -n "$ALT_USER" ]]; then
  USER_NAME=$ALT_USER
fi

# day offsets can only be negative
if [[ "$DAYS_OFFSET" -gt 0 ]]; then
  DAYS_OFFSET=$(( -DAYS_OFFSET ))
  echo "Warning: Converting positive offset to negative: $DAYS_OFFSET"
fi

# MACOS DATE COMMAND IS DIFFERENT 
if [[ "$(uname)" == "Darwin" ]]; then
  if [[ "$DAYS_OFFSET" -eq 0 ]]; then
    TARGET_DATE=$(date +"%Y/%B/%d")
  else
    TARGET_DATE=$(date -v "${DAYS_OFFSET}d" +"%Y/%B/%d")
  fi
else
  # Linux/Unix
  if [[ "$DAYS_OFFSET" -eq 0 ]]; then
    TARGET_DATE=$(date +"%Y/%B/%d")
  else
    TARGET_DATE=$(date -d "${DAYS_OFFSET} days" +"%Y/%B/%d")
  fi
fi

if [[ $? -ne 0 ]]; then
  echo "Invalid date offset: $DAYS_OFFSET"
  exit 1
fi

TARGET_DIR="$BASE_PATH/$USER_NAME/$TARGET_DATE"


# Directory can only be made if it belongs to the current user and the date is today
if [[ "$USER_NAME" == "$(whoami)" && "$DAYS_OFFSET" -eq 0 ]]; then
  if [[ ! -d "$TARGET_DIR" ]]; then
    mkdir -p "$TARGET_DIR"
    if [[ $? -eq 0 ]]; then
      chmod 777 "$TARGET_DIR"
      echo "Created directory: $TARGET_DIR"
    else
      echo "Failed to create directory: $TARGET_DIR"
      exit 1
    fi
  fi
fi


if [[ -d "$TARGET_DIR" ]]; then
  cd "$TARGET_DIR" || { echo "Cannot access directory: $TARGET_DIR"; exit 1; }
  echo -e "\e[33m---------- $(pwd) ----------\e[0m"
else
  echo "Directory does not exist: $TARGET_DIR"
  if [[ "$USER_NAME" != "$(whoami)" ]]; then
    echo "Cannot create directory for another user: $USER_NAME"
  elif [[ "$DAYS_OFFSET" -ne 0 ]]; then
    echo "Cannot create directory with a date offset: $DAYS_OFFSET"
  fi
  exit 1
fi