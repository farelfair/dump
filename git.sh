#!/bin/bash

# Pastikan sudah git init dan punya remote
branch=$(git rev-parse --abbrev-ref HEAD)

# Loop semua file yg merah (untracked atau deleted)
git status --porcelain | grep -E '^\?\? |^ D' | while read -r status file; do
    # Untuk file untracked
    if [[ $status == "??" ]]; then
        echo "Menambahkan file baru: $file"
        git add "$file"
        git commit -m "Add $file"
    # Untuk file yang dihapus
    elif [[ $status == "D" || $status == " D" ]]; then
        echo "Menghapus file: $file"
        git rm "$file"
        git commit -m "Remove $file"
    fi

    echo "Push perubahan untuk $file"
    git push origin "$branch"
    echo "-----------------------------"
done
