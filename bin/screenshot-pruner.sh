#!/usr/bin/env bash
set -euo pipefail

#
# Make it easy to remove screenshots that are no longer being used
#

images_dir="modules/ROOT/images"

# For all screenshots
for image in $( find $images_dir -type f); do
  image_basename=$( basename $image )

  # Grep for any references to the image
  if [[ -z $( git grep $image_basename ) ]]; then
    # No references found so assume screenshot can be discarded
    echo Removing $image
    git rm $image

  else
    # Screenshot still in use so keep it
    echo Keeping $image

  fi
done
