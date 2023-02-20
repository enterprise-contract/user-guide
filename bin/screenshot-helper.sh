#!/usr/bin/env bash
set -euo pipefail

#
# Try to make it less annoying to add and manage screenshots
#

file_ext="png"
downloads_dir="$HOME/Downloads"
images_dir="modules/ROOT/images"

# Find latest screenshot, presumably created by Firefox or Chrome
fresh_screenshot_file=$( ls -ft ${downloads_dir}/*.${file_ext} | head -1 )

# You can provide the file as an argument if you want
png_file="${1:-$fresh_screenshot_file}"

# Find its digest
file_digest=$( md5sum "${png_file}" | awk '{print $1}' )
file_name="${file_digest}.${file_ext}"

# Copy the image and echo some asciidoc for copy/paste
cp "${png_file}" "${images_dir}/${file_name}"

asciidoc_snippet="image::${file_name}[]"
echo  "${asciidoc_snippet}" | xclip -selection clipboard
echo "This should be in your clipboard ready to paste:"
echo "$asciidoc_snippet"
