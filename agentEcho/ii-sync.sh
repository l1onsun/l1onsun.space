git stash
git fetch
git reset --hard origin/$(git -C "$ORIGINAL_PROJECT_DIR" branch --show-current)
git -C "$ORIGINAL_PROJECT_DIR" diff HEAD | git apply --index --allow-empty
