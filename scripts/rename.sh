#!/bin/env sh

rand_id() {
    tr -dc 'a-z0-9' </dev/urandom | head -c 7
}

rename_file() {
    file="$1"
    base="$(basename "$file")"
    prefix="uwu_"

    case "$base" in
        $prefix*) return ;;
    esac

    dir="$(dirname "$file")"
    ext="${base##*.}"

    rand="$(rand_id)"
    newname="${prefix}${rand}.${ext}"

    if mv "$file" "$dir/$newname"; then
        echo "Renamed: $file -> $dir/$newname"
    fi
}

# Does not recurse into directories. walk_dir will do this.
rename_dir_files() {
    dir=$1
    for file in "$dir"/*; do
        if [ -f "$file" ]; then 
            rename_file "$file"
        fi
    done
}

walk_dir() {
    # sanitize trailing /
    root=$(echo $1 | sed 's/\/$//')
    rename_dir_files "$root"

    for dir in "$root"/*; do
        if [ -d "$dir" ]; then
            walk_dir "$dir"
        fi
    done
}

if [ $# -ne 1 ]; then
    echo "Usage: rename.sh <PATH>"
else
    walk_dir "$1"
fi

