#!/usr/bin/env fish

for f in (git ls-files)
  diff -u "$ORIGINAL_PROJECT_DIR/$f" "$f"
end
