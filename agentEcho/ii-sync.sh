target=$(git -C "$ORIGINAL_PROJECT_DIR" branch --show-current)
git stash
git fetch
git checkout -B $target origin/$target
git -C "$ORIGINAL_PROJECT_DIR" diff HEAD | git apply --index --allow-empty
