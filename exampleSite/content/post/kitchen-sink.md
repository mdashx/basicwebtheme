+++
title = "Kitchen Sink"
date = 2026-01-09T00:00:00Z
draft = false
tags = ["demo", "reference"]
SubTitle = "Every element the theme renders, on one page."
+++

This page demonstrates every visual element available. Use it to preview how your content will look before you write it.

---

### Headings

The layout renders the page title as `h2`. Your content headings start at `h3`.

### h3 — Top-level section
#### h4 — Sub-section
##### h5 — Rarely needed
###### h6 — Almost never needed

---

### Paragraph text

Regular paragraph text is set in your system's default sans-serif font at the browser's default size (typically 16px). Line length is constrained to ~65 characters on desktop — the width of the column — which keeps reading comfortable without needing explicit line-height tricks.

You can use **bold**, *italic*, ~~strikethrough~~, and `inline code` within a paragraph. Links look [like this](/about) and are underlined by default.

---

### Unordered lists

- First item
- Second item
- Third item
  - Nested item
  - Another nested item
- Back to the top level

### Ordered lists

1. First step
2. Second step
3. Third step
   1. Sub-step A
   2. Sub-step B
4. Fourth step

---

### Blockquotes

> A blockquote is rendered with a subtle left indent and muted text color. Good for pull quotes, citations, or anything you want visually separated from the main flow.

> Multi-paragraph blockquotes work too.
>
> Each paragraph stays inside the same quote block.
>
> — Attribution, if needed

---

### Code blocks

Short inline code: `hugo server --buildDrafts`

A shell block:

```bash
cd my-site
hugo mod get github.com/mdashx/basicwebtheme
hugo server --bind 0.0.0.0 --port 1313
```

A Go block:

```go
package main

import "fmt"

func main() {
    fmt.Println("Hello, Basic Web Theme")
}
```

A Python block:

```python
def slugify(title: str) -> str:
    return title.lower().replace(" ", "-")

posts = ["Hello World", "Getting Started", "Typography"]
for post in posts:
    print(f"/post/{slugify(post)}/")
```

A JSON block:

```json
{
  "title": "My Site",
  "params": {
    "HeaderText": "My Site",
    "HighlightTheme": "nord",
    "mainSections": ["post"]
  }
}
```

A TOML config block:

```toml
baseURL  = "https://example.com"
title    = "My Site"

[params]
  HeaderText     = "My Site"
  HighlightTheme = "nord"

[[menu.main]]
  title  = "Home"
  url    = "/"
  weight = 1
```

Long lines scroll horizontally without breaking the column:

```
This is a very long line of code that extends well past the 500px column width and will scroll horizontally instead of wrapping or overflowing into the surrounding layout.
```

---

### Tables

| Language | Released | Paradigm |
|----------|----------|----------|
| Go | 2009 | Compiled, concurrent |
| Python | 1991 | Interpreted, multi-paradigm |
| JavaScript | 1995 | Interpreted, event-driven |
| Rust | 2015 | Compiled, systems |
| HTML | 1993 | Markup |

Tables are full-bleed (minimum 90vw) and scroll horizontally on narrow viewports.

---

### Horizontal rules

Use `---` in Markdown to insert a horizontal rule. Good for separating major sections within a post.

---

### Images

Images scale to fit the column and never overflow. On desktop the max-width is 500px.

![Basic Web Theme example image — placeholder](/assets/favicon.png)

(This is the favicon used as a placeholder. Replace with a real image at `/assets/images/your-image.png`.)

---

### Nested blockquote and code

> You can mix elements. Here's a blockquote containing inline `code` and **bold text**.
>
> Useful for documenting configuration values or quoting technical content.
