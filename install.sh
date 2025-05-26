#!/usr/bin/env bash

SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )")
FILES="${SCRIPT_DIR}/homefiles"
BACKUP_DIR="${SCRIPT_DIR}/.backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Create backup directory if it doesn't exist
mkdir -p "${BACKUP_DIR}"

# Function to recursively copy files and directories
copy_recursively() {
    local source_dir="$1"
    local target_dir="$2"

    # Find all files including dotfiles recursively
    find "${source_dir}" -type f | while read -r source_file; do
        # Get the relative path from source directory
        local rel_path="${source_file#$source_dir/}"
        local target_file="${target_dir}/${rel_path}"
        local target_file_dir=$(dirname "${target_file}")

        # Skip if files are identical
        if [[ -f "${target_file}" ]] && cmp -s "${source_file}" "${target_file}"; then
            echo "Skipping identical file: ${rel_path}"
            continue
        fi

        echo "=== ${rel_path} ==="

        if [[ ! -f "${target_file}" ]]; then
            echo "New file (doesn't exist in home)"
            head -10 "${source_file}"
        else
            diff -u "${target_file}" "${source_file}" || true
        fi

        echo ""

        # Backup existing file
        if [[ -f "${target_file}" ]]; then
            local backup_path="${BACKUP_DIR}/${TIMESTAMP}_${rel_path//\//_}"
            mkdir -p "$(dirname "${backup_path}")"
            cp "${target_file}" "${backup_path}"
            echo "Backed up original to ${backup_path}"
        fi

        # Always ensure the target directory exists before copying
        if [[ ! -d "${target_file_dir}" ]]; then
            mkdir -p "${target_file_dir}"
            echo "Created directory ${target_file_dir}"
        else
            echo "Using existing directory: ${target_file_dir}"
        fi

        # Copy file after directory is confirmed to exist
        cp "${source_file}" "${target_file}"
        echo "Copied ${rel_path} to ${target_file}"

        echo ""
    done
}

# Recursively copy files from homefiles to home directory
copy_recursively "${FILES}" "${HOME}"

echo "Done! Backups stored in ${BACKUP_DIR}"
