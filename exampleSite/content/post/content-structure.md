+++
title = "Content Structure"
date = 2026-01-06T00:00:00Z
draft = false
tags = ["setup", "reference"]
SubTitle = "Sections, archives, tags, and how pages relate to each other."
+++

### Directory structure

Hugo sections map to subdirectories in `content/`. A minimal site:

```
content/
  _index.md          ← homepage
  about.md           ← standalone page
  post/
    _index.md        ← post list page
    my-first-post.md
    my-second-post.md
```

Each section automatically gets a list page at its URL — `/post/` shows all content inside `content/post/`.

A fuller site might look like:

```
content/
  _index.md
  about.md
  contact.md
  colophon.md
  archives/
    _index.md
  post/
    _index.md
    getting-started.md
    typography.md
```

### The homepage

The homepage pulls from whatever sections are listed in `mainSections`:

```toml
[params]
  mainSections = ["post"]
```

The `_index.md` file can contain a short intro above the post list. If it's empty, the list starts immediately.

### The archives section

Create `content/archives/_index.md` to get a compact chronological index of all posts with their dates and tags:

```markdown
+++
title = "Archive"
+++
```

Add it to your footer menu:

```toml
[[menu.main]]
  title  = "Archive"
  url    = "/archives"
  weight = 10
```

### Tags

Add tags to any post and they become links at the bottom of the page. A tag index at `/tags/` lists all tags. Each tag page shows all posts with that tag.

```toml
tags = ["web", "tools", "history"]
```

Tags are the primary way readers navigate beyond the homepage and archive. Use them consistently.

### Authors

The `authors` taxonomy works like tags. Configure it in `hugo.toml`:

```toml
[taxonomies]
  tag    = "tags"
  author = "authors"
```

Then in front matter:

```toml
authors = ["jane-doe"]
```

Author names in URLs are URL-encoded — `jane-doe` becomes `/authors/jane-doe/`.

### Standalone pages

Any `.md` file directly in `content/` (not inside a section subdirectory) becomes a standalone page. It gets a single-page layout with no automatic list behavior.

```
content/about.md    → /about/
content/contact.md  → /contact/
content/colophon.md → /colophon/
```

Link to them from your footer menu or inline from other content.

### Linking between pages

Use root-relative paths in Markdown:

```markdown
See the [about page](/about) for more.
Read the [first post](/post/getting-started).
```

For links that survive if you move content, use Hugo's `relref` shortcode:

```markdown
See the [about page]({{</* relref "about" */>}}) for more.
```
