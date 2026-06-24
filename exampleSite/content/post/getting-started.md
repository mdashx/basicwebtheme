+++
title = "Getting Started"
date = 2026-01-02T00:00:00Z
draft = false
tags = ["setup", "hugo-modules"]
SubTitle = "Install the theme and get a site running in a few minutes."
+++

### Prerequisites

- Hugo extended v0.112.0 or later
- Go 1.21 or later (required for Hugo Modules)

Check your versions:

```bash
hugo version
go version
```

### Create a new site

```bash
hugo new site my-site
cd my-site
git init
hugo mod init github.com/yourname/my-site
```

### Add the theme

In `hugo.toml`:

```toml
[module]
  [[module.imports]]
    path = "github.com/mdashx/basicwebtheme"
```

Then pull it:

```bash
hugo mod get github.com/mdashx/basicwebtheme
```

### Minimal config

A working `hugo.toml` to get started:

```toml
baseURL  = "https://example.com"
title    = "My Site"

[params]
  HeaderText   = "My Site"

[params.mainSections]
  mainSections = ["post"]

[[menu.main]]
  title  = "Home"
  url    = "/"
  weight = 1

[[menu.main]]
  title  = "Posts"
  url    = "/post"
  weight = 2

[[menu.main]]
  title  = "About"
  url    = "/about"
  weight = 3

[module]
  [[module.imports]]
    path = "github.com/mdashx/basicwebtheme"
```

### Create your first post

```bash
hugo new content post/my-first-post.md
```

Edit the file — set `draft = false` when ready to publish.

### Run the dev server

```bash
hugo server --buildDrafts
```

Visit `http://localhost:1313`. The server live-reloads on every save.

### Using a local copy of the theme

Add this to your `go.mod`:

```
replace github.com/mdashx/basicwebtheme => ../basicwebtheme
```

Hugo will resolve the theme from the local path instead of fetching from GitHub. Useful during theme development.
