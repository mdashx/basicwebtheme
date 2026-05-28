# Basic Web Theme — Jinja2 port

A lightweight [Jinja2](https://jinja.palletsprojects.com/) port of the Basic
Web Theme, meant for use from Python (Flask, FastAPI, or plain Jinja2). It
reproduces the theme's shell — base layout, head/header/footer, single page,
and list/index — while keeping the same minimal, text-first aesthetic.

This is **not** a full Hugo port. Hugo features like content rendering from
Markdown, taxonomies, sections, shortcodes, and shuffling are *not* included.
You supply already-rendered HTML and plain Python data; these templates just
lay it out. See [Differences from the Hugo theme](#differences-from-the-hugo-theme).

## Layout

```
jinja2/
└── templates/
    ├── base.html              # base layout (port of layouts/_default/baseof.html)
    ├── page.html              # single content page (port of single.html)
    ├── list.html              # list / index page (port of list.html + index.html)
    └── partials/
        ├── head.html          # <head> (port of partials/head.html)
        ├── header.html        # site header (port of partials/header.html)
        ├── footer.html        # footer + menu (port of partials/footer.html)
        └── macros.html        # format_date, post_preview, taxonomy_terms
```

`page.html` and `list.html` both `{% extends "base.html" %}` and fill the
`main` block, mirroring Hugo's `{{ define "main" }}`.

## Styling — reuse the existing CSS

These templates do **not** ship a new stylesheet. They link to
`{{ static_url }}/css/style.css` and `{{ static_url }}/favicon.png`, which
should point at the theme's existing assets in `static/assets/` at the repo
root. Copy or symlink them into whatever directory your app serves as static
files, e.g.:

```sh
cp static/assets/css/style.css   your_app/static/css/style.css
cp static/assets/favicon.png     your_app/static/favicon.png
```

## Context variables

`site` and `static_url` are global; `page` / `pages` are per-view.

### Global

| Variable     | Type     | Notes                                                              |
|--------------|----------|--------------------------------------------------------------------|
| `site`       | dict     | `title`, `description`, optional `header_text` / `header_image`, optional `menu` (list of `{title, url}`). |
| `static_url` | str      | Base URL for static assets. Defaults to `/static`.                 |
| `now`        | datetime | Optional. If set, the footer shows an "Updated: …" line.           |
| `is_home`    | bool     | Optional. When true, `<meta description>` uses `site.description`.  |

### `page` (for `page.html`, and the section page on `list.html`)

| Field          | Type     | Notes                                                  |
|----------------|----------|--------------------------------------------------------|
| `title`        | str      | Page title.                                            |
| `content`      | str/HTML | Rendered HTML body. Output with `\| safe`.             |
| `subtitle`     | str      | Optional.                                              |
| `description`  | str      | Optional, used in `<meta description>`.                |
| `date`         | datetime | Optional publish date.                                 |
| `skip_title`   | bool     | Optional. Suppresses the `<h2>` title.                 |
| `authors`      | list     | Optional list of `{name, url}` dicts.                  |
| `tags`         | list     | Optional list of `{name, url}` dicts.                  |
| `header_text`  | str      | Optional per-page header override.                     |
| `header_image` | str      | Optional per-page header override.                     |
| `show_date`    | bool     | Optional. Defaults to **true** on single pages.        |

### `list.html`

| Variable               | Type | Notes                                                       |
|------------------------|------|-------------------------------------------------------------|
| `pages`                | list | Page dicts to preview. Each needs `title`, `url`, `content`; optional `summary`, `date`. |
| `page`                 | dict | Optional. Its `content` is rendered above the list.         |
| `big_title`            | bool | Optional, default true. `<h2>` headings vs. inline titles.  |
| `show_date`            | bool | Optional, default false. Show dates instead of URLs.        |
| `preview_full_content` | bool | Optional, default false. Render full `content` vs. summary. |

Each preview shows `summary` if present, otherwise the `content` truncated to
~200 characters (HTML stripped). Set `preview_full_content=True` to show the
full `content`.

## Using it with Flask

```python
from datetime import datetime
from flask import Flask, render_template

app = Flask(__name__, template_folder="jinja2/templates")

SITE = {
    "title": "My Site",
    "description": "A basic site.",
    "header_text": "My Site",
    "menu": [{"title": "About", "url": "/about"}],
}

@app.route("/")
def home():
    pages = [
        {"title": "Hello", "url": "/hello", "content": "<p>First post.</p>"},
    ]
    return render_template(
        "list.html", site=SITE, now=datetime.now(), is_home=True, pages=pages
    )

@app.route("/hello")
def hello():
    page = {"title": "Hello", "content": "<p>First post.</p>", "date": datetime.now()}
    return render_template("page.html", site=SITE, now=datetime.now(), page=page)
```

To render without Flask, point a `jinja2.Environment` at the templates folder:

```python
from jinja2 import Environment, FileSystemLoader

env = Environment(loader=FileSystemLoader("jinja2/templates"), autoescape=True)
html = env.get_template("page.html").render(site=SITE, page=page)
```

## Differences from the Hugo theme

- No Markdown rendering — pass pre-rendered HTML in `content` / `summary`.
- No automatic taxonomy/section pages — build `tags`/`authors` link lists and
  `pages` collections yourself in Python.
- `urlize` / `shuffle` / `where` filters are not reproduced; do that work in
  Python before rendering (e.g. `random.shuffle(pages)`).
- Permalink vs. relative-permalink is collapsed to a single `url` field.
