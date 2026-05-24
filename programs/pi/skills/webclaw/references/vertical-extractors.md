# Vertical Extractors

28 site-specific extractors returning typed JSON instead of generic markdown.

## Discovery

```bash
# List all extractors
webclaw extractors

# As JSON
webclaw extractors --json
```

## Usage

```bash
# Run extractor
webclaw vertical <name> <url>

# Single-line JSON for piping
webclaw vertical <name> <url> --raw
```

## Available Extractors

### Social & Forums

| Extractor | URL Pattern | Notes |
|-----------|-------------|-------|
| `reddit` | reddit.com/r/*/comments/* | Thread + comments |
| `reddit_user` | reddit.com/user/* | User profile |
| `reddit_subreddit` | reddit.com/r/* | Subreddit info |

### Developer Platforms

| Extractor | URL Pattern | Notes |
|-----------|-------------|-------|
| `github_repo` | github.com/*/* | Repo metadata, stars, forks |
| `github_pr` | github.com/*/*/pull/* | PR details, diff |
| `github_issue` | github.com/*/*/issues/* | Issue + comments |
| `github_discussion` | github.com/*/*/discussions/* | Discussion thread |
| `github_user` | github.com/* | User profile |
| `pypi` | pypi.org/project/* | Package info |
| `npm` | npmjs.com/package/* | Package info |
| `crates_io` | crates.io/crates/* | Crate info |

### E-Commerce

| Extractor | URL Pattern | Notes |
|-----------|-------------|-------|
| `amazon_product` | amazon.com/dp/* | Name, price, rating |
| `amazon_search` | amazon.com/s?* | Search results |

### Media

| Extractor | URL Pattern | Notes |
|-----------|-------------|-------|
| `youtube_video` | youtube.com/watch* | Video metadata |
| `youtube_channel` | youtube.com/@* | Channel info |
| `spotify_track` | open.spotify.com/track/* | Track info |
| `spotify_album` | open.spotify.com/album/* | Album info |
| `spotify_playlist` | open.spotify.com/playlist/* | Playlist info |

### News & Content

| Extractor | URL Pattern | Notes |
|-----------|-------------|-------|
| `hackernews` | news.ycombinator.com/item* | Post + comments |
| `substack` | *.substack.com/p/* | Article |
| `medium` | medium.com/* | Article |
| `wikipedia` | wikipedia.org/wiki/* | Article |

### Other

| Extractor | URL Pattern | Notes |
|-----------|-------------|-------|
| `google_maps` | google.com/maps/place/* | Place info |
| `yelp` | yelp.com/biz/* | Business info |
| `apple_maps` | maps.apple.com/* | Place info |
| `twitter` | x.com/*/status/* | Tweet |
| `linkedin_profile` | linkedin.com/in/* | Profile |

## Piping with jq

```bash
# Extract specific fields
webclaw vertical github_repo https://github.com/rust-lang/rust --raw \
  | jq '{stars, forks, primary_language}'

# Get Reddit comments
webclaw vertical reddit https://reddit.com/r/rust/comments/abc/title --raw \
  | jq '.comments[].body'
```

## Notes

- Vertical output is stable per extractor name
- Extractor catalog grows over time
- Check `webclaw extractors` in CI to catch renames
