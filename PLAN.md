# Plan: Modernize basicwebtheme for Hugo Modules

## Context

The theme was built before Hugo Modules existed. It has no `go.mod`, so it can't
be consumed as a module — users are stuck with git submodules or the old `themesDir`
hack. The `exampleSite` inside the repo still uses `themesDir = "../.."`. The
`basic-hugo-site` we built uses a raw symlink. Goal: make the theme a proper Hugo
Module, update the exampleSite to consume it that way, and rewire basic-hugo-site
to do the same (no more symlink).

The theme's intentional minimalism (no Tailwind, no build pipeline, raw CSS) is a
design choice — we don't touch that. Scope is Go/Hugo module wiring only, plus a
few small housekeeping fixes we'll pick up along the way.

---

## Step 1 — Add go.mod to the theme

```
cd /home/easter/basicwebtheme
hugo mod init github.com/mdashx/basicwebtheme
```

This creates `go.mod` with `module github.com/mdashx/basicwebtheme` and the
current Go version. No other files change.

---

## Step 2 — Update theme.toml

Bump `min_version` from `"0.59.1"` to `"0.112.0"` (the minimum that supports
Hugo Modules reliably and `hugo.toml` configs). Keep `theme.toml` as-is otherwise
— the Hugo themes gallery still requires it.

File: `/home/easter/basicwebtheme/theme.toml`

---

## Step 3 — Fix archetype

The default archetype at `archetypes/default.md` is empty (just `+++ +++`).
Replace with useful front matter so `hugo new content` scaffolds real posts:

```toml
+++
title = '{{ replace .File.ContentBaseName "-" " " | title }}'
date = {{ .Date }}
draft = true
tags = []
+++
```

File: `/home/easter/basicwebtheme/archetypes/default.md`

---

## Step 4 — Fix the archvies.html typo

There are three section layouts with overlapping/confusing names:
- `layouts/section/archive.html`
- `layouts/section/archives.html`
- `layouts/section/archvies.html` ← typo, should be deleted

Delete `archvies.html`. Hugo will fall back to `archives.html` or the `_default`
list for any `archvies` section (which shouldn't exist anyway).

File to delete: `/home/easter/basicwebtheme/layouts/section/archvies.html`

---

## Step 5 — Modernize exampleSite

### 5a — Rename config
Rename `exampleSite/config.toml` → `exampleSite/hugo.toml` (Hugo's preferred
config filename since v0.110.0).

### 5b — Init exampleSite as a Hugo Module
```
cd /home/easter/basicwebtheme/exampleSite
hugo mod init github.com/mdashx/basicwebtheme/exampleSite
```

### 5c — Replace themesDir with module import
Remove from `hugo.toml`:
```toml
themesDir = "../.."
theme = "basicwebtheme"
```

Add:
```toml
[module]
  [[module.imports]]
    path = "github.com/mdashx/basicwebtheme"
```

### 5d — Add go.work at theme root
Create `/home/easter/basicwebtheme/go.work` so the exampleSite resolves the theme
locally without needing a `replace` directive:

```
go 1.21

use (
    .
    ./exampleSite
)
```

This means `cd exampleSite && hugo server` just works, using the local theme.

---

## Step 6 — Rewire basic-hugo-site

### 6a — Remove the symlink
```
rm /home/easter/basic-hugo-site/themes/basicwebtheme
```

### 6b — Update basic-hugo-site/hugo.toml
Remove `theme = 'basicwebtheme'` (no longer needed with modules).
Add:
```toml
[module]
  [[module.imports]]
    path = "github.com/mdashx/basicwebtheme"
```

### 6c — Add replace directive to basic-hugo-site/go.mod
```
require github.com/mdashx/basicwebtheme v0.0.0-00010101000000-000000000000

replace github.com/mdashx/basicwebtheme => ../basicwebtheme
```

Run `hugo mod tidy` to clean up.

---

## Files changed summary

| File | Action |
|------|--------|
| `basicwebtheme/go.mod` | Create (new) |
| `basicwebtheme/go.work` | Create (new) |
| `basicwebtheme/theme.toml` | Edit min_version |
| `basicwebtheme/archetypes/default.md` | Edit (add real front matter) |
| `basicwebtheme/layouts/section/archvies.html` | Delete |
| `basicwebtheme/exampleSite/config.toml` | Rename → hugo.toml |
| `basicwebtheme/exampleSite/hugo.toml` | Edit (remove themesDir, add module import) |
| `basicwebtheme/exampleSite/go.mod` | Create (new) |
| `basic-hugo-site/hugo.toml` | Edit (remove theme=, add module import) |
| `basic-hugo-site/go.mod` | Edit (add require + replace) |
| `basic-hugo-site/themes/basicwebtheme` (symlink) | Delete |

---

## Verification

1. `cd /home/easter/basicwebtheme/exampleSite && hugo server` — should build and
   serve with no `themesDir` warning, resolving theme via go.work
2. `curl http://100.127.66.112:1313/` — confirm basic-hugo-site still serves
   after symlink is removed and module wiring is in place
3. `hugo mod graph` from basic-hugo-site — should show `github.com/mdashx/basicwebtheme`
   as a dependency resolved to the local path
