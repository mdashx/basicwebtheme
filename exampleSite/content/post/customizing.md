+++
title = "Customizing the Theme"
date = 2026-01-08T00:00:00Z
draft = false
tags = ["setup", "css"]
SubTitle = "Dark mode is automatic. Custom CSS is one file."
+++

### Dark mode

The theme supports dark mode automatically via `prefers-color-scheme`. No configuration needed. When the visitor's OS is in dark mode:

- Background → `#282828`
- Text → `#EEEEEE`
- Links → `#EEEEEE`

You don't need to do anything to support this. If you add custom CSS, add matching `@media (prefers-color-scheme: dark)` rules for any hardcoded colors.

### Custom CSS

The theme loads one stylesheet: `/assets/css/style.css`. To add styles without modifying the theme, create the same file path in your own site:

```
static/
  assets/
    css/
      style.css
```

Your site's `static/` directory takes precedence over the theme's. **Copy the theme's CSS first, then add your overrides at the bottom** — otherwise you lose the base styles entirely.

### Syntax highlighting

The theme supports class-based syntax highlighting via Hugo's built-in Chroma highlighter. Enable it in `hugo.toml`:

```toml
[params]
  HighlightTheme = "nord"

[markup.highlight]
  noClasses = false
```

Available themes (CSS files ship with the theme):

| Name | Style |
|------|-------|
| `nord` | Cool arctic blues and greys |
| `dracula` | Dark purple and pink |
| `one-dark` | Atom's classic warm dark |
| `github-dark` | Clean GitHub-style dark |
| `gruvbox-dark` | Warm earthy retro |

To remove highlighting entirely, leave `HighlightTheme` unset. Code blocks will render in the muted monospace color defined in `style.css`.

### Favicon

Place your favicon at `static/assets/favicon.png`. The theme links three sizes (16×16, 32×32, 96×96) all pointing to the same file — replace it with your own.

For best results across devices, use a 96×96 PNG or an SVG. To use an SVG favicon, override `layouts/partials/head.html` in your own site with a single `<link rel="icon" type="image/svg+xml">` tag.

### Overriding layouts

Any layout file you create in your site's `layouts/` directory overrides the theme's version. To customize a partial:

1. Find the file in `basicwebtheme/layouts/partials/`
2. Copy it to `your-site/layouts/partials/` with the same filename
3. Edit your copy

Hugo picks up your version automatically. You never modify the theme files directly.

### Information architecture

Given the single-column, footer-nav model, a clean IA pattern for a content-heavy site:

```
Homepage     ← recent posts + brief intro
Posts        ← chronological list
Archive      ← same content, compact date-indexed view
About        ← who, why
Now          ← what you're working on right now
Uses         ← tools and setup
Contact      ← how to reach you
```

Footer (suggested):
```
Home · Posts · Archive · About · Contact
```

Keep it to five or six entries. Everything else is reachable via tags or inline links.
