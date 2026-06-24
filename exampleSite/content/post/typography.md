+++
title = "Typography"
date = 2026-01-04T00:00:00Z
draft = false
tags = ["content", "reference"]
SubTitle = "Start your headings at h3. The layout owns h1 and h2."
+++

The theme uses the system font stack and browser defaults for sizing. The heading levels have a fixed mapping between the theme's layout and your content — understanding it prevents duplicate headings at the same visual weight.

### Heading hierarchy

| Level | Rendered by | Purpose |
|-------|-------------|---------|
| `h1` | The theme | Site name in the header (text mode). Never use in content. |
| `h2` | The theme | Page or post title. Never use as a content heading. |
| `h3` | You | Top-level sections within a post or page. |
| `h4` | You | Sub-sections. |
| `h5`, `h6` | You | Rarely needed. |

The layout puts the page title in an `<h2>` above your Markdown content. If you also write `## Section` headings inside the content, you get two visual heading levels competing at the same weight. Start at `### Section` instead.

```markdown
+++
title = "My Post"   ← rendered as <h2> by the layout
+++

### First section   ← start here, not ##
#### A sub-point
```

### Subtitle

The `SubTitle` front matter param renders as `<em>` immediately below the title — a good place for a lede, a date range, or a clarifying phrase.

```toml
SubTitle = "A short clarifying sentence that appears under the title."
```

### Skip the title entirely

Set `skipTitle = true` in front matter if you want to handle the heading yourself — useful for custom page designs where the layout's automatic `<h2>` would be redundant.

### Blockquotes

Blockquotes are slightly indented and rendered in a muted color in both light and dark mode.

> This is a blockquote. Use it for pull quotes, citations, or anything you want visually set apart from the main text flow.
>
> It can span multiple paragraphs.

```markdown
> This is a blockquote.
```

### Inline code and code blocks

Inline `code` renders in a monospace font at 95% size with a muted color.

Fenced code blocks get horizontal scroll on overflow — long lines won't break your column.

```python
def greet(name: str) -> str:
    return f"Hello, {name}"

print(greet("world"))
```

```bash
hugo server --bind 0.0.0.0 --port 1313 --buildDrafts
```

### Tables

Tables are full-bleed (minimum `90vw`) with a light border. The first row becomes a header when you use the standard Markdown table syntax.

| Column A | Column B | Column C |
|----------|----------|----------|
| Value 1  | Value 2  | Value 3  |
| Value 4  | Value 5  | Value 6  |

```markdown
| Column A | Column B | Column C |
|----------|----------|----------|
| Value 1  | Value 2  | Value 3  |
```

### Images

Images are constrained to the column width. They will never overflow.

```markdown
![Alt text](/assets/images/my-image.png)
```

Put images in `static/assets/images/`. Prefer SVG for diagrams and illustrations — they scale perfectly and are often smaller than raster equivalents.
