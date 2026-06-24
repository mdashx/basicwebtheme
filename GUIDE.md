# Basic Web Theme — Implementation Guide

This guide covers how to structure and build a site with Basic Web Theme. The theme
is intentionally small: a handful of layout rules, one column, no JavaScript, and
a very short vocabulary of things you can do with it. That smallness is the point.
Read this once and you'll know everything the theme can do.

---

## Design philosophy

The column is 500px wide on desktop — about the width of a mobile screen, and close
to the optimal line length for reading (~65–70 characters). On mobile it fills the
viewport. Nothing competes for the reader's attention. There is no sidebar, no
hero image, no card grid. Every page is just content in a column.

**The theme does not have a navigation bar.** Navigation lives in the footer.
The header is a logo or title that always links back to the homepage. That's it.
If your content needs more wayfinding than that, the answer is links inside your
content and a well-organized footer menu — not a nav bar.

---

## Page structure

Every page has the same structure:

```
[header — logo/name, links home]
[hr]
[main — your content]
[hr]
[footer — nav links + last-updated date]
```

There are no sidebars, no breadcrumbs, no pagination UI (yet). What you see above
is the complete chrome of every page.

---

## Setting up the header

The header is configured in your site's `hugo.toml` under `[params]`. You get
one of two options:

**Option A — Text header**
```toml
[params]
  HeaderText = "My Site"
```
Renders as an `<h1>` linked to `/`.

**Option B — Image header**
```toml
[params]
  HeaderImage = "/assets/images/header.svg"
```
Renders as an `<img>` linked to `/`. SVG works best — it scales cleanly to any
column width without going blurry.

Put your image in `static/assets/images/`. Whatever you put in `static/` is served
at the root, so `static/assets/images/header.svg` becomes `/assets/images/header.svg`.

A page can also override the header with its own `HeaderText` or `HeaderImage` front
matter param, but this is rarely useful — the header is the same on every page by
design.

---

## Setting up navigation (the footer)

All navigation lives in `[[menu.main]]` entries in `hugo.toml`. The footer renders
every item in this menu as an inline link, followed by a "last updated" timestamp.

```toml
[[menu.main]]
  title = "Home"
  name  = "Home"
  url   = "/"
  weight = 1

[[menu.main]]
  title = "Posts"
  name  = "Posts"
  url   = "/posts"
  weight = 2

[[menu.main]]
  title = "About"
  name  = "About"
  url   = "/about"
  weight = 3
```

`weight` controls order. `title` is what's displayed. Keep this list short — five
or six items is about the limit before the footer gets crowded on mobile.

**There is no top navigation.** If a page needs to be discoverable, it goes in the
footer menu or is linked from the homepage.

---

## Typography rules

The theme uses the system font stack (`sans-serif`) and browser defaults for most
sizing. Here is how heading levels map to purpose:

| Level | Rendered by | Purpose |
|-------|-------------|---------|
| `h1`  | The theme layout | Site name in the header (text mode). Do not use `h1` in content. |
| `h2`  | The theme layout | Page or post title. Do not use `h2` as the first heading in content — the layout already renders it. |
| `h3`  | You, in content | Top-level section headings within a post or page. |
| `h4`  | You, in content | Sub-sections. |
| `h5`, `h6` | You, in content | Rarely needed. Use sparingly. |

The rule is: **start your content headings at `h3`**. The layout puts the page
title in an `h2` above your content — if you also use `h2` inside the content,
the page ends up with competing same-weight headings.

```markdown
+++
title = "My Post"   ← becomes the <h2> above your content
+++

### First section    ← start here
```

---

## Front matter reference

These are the params the theme reads. All are optional unless noted.

### On any page or post

| Param | Type | Effect |
|-------|------|--------|
| `title` | string | **Required.** Rendered as `<h2>` above the content on single pages, and as the post title in list views. |
| `date` | datetime | Used for sorting and display. |
| `draft` | bool | Set to `false` to publish. |
| `description` | string | Used in the `<meta name="description">` tag. |
| `SubTitle` | string | Rendered as `<em>` below the title on single pages. Good for a one-line lede. |
| `skipTitle` | any | If set to any value, the layout skips rendering the `<h2>` title. Use when you want full control over your page's heading. |
| `tags` | list | Taxonomy. Rendered as tag links at the bottom of single pages. |
| `authors` | list | Taxonomy. Rendered as author links at the bottom of single pages. |

### On list pages (section `_index.md` files)

| Param | Type | Effect |
|-------|------|--------|
| `showdate` | bool | Show publish date in post previews. |
| `bigtitle` | bool | Show post title as a large `<h2>` link (default). Set `false` for a compact `<em>` style list. |
| `previewfullcontent` | bool | Show full post content in the list instead of truncating at 200 characters. |
| `randomorder` | bool | Shuffle the post order on each load. |

### Site-level params (in `hugo.toml [params]`)

| Param | Type | Effect |
|-------|------|--------|
| `HeaderText` | string | Site name text in the header. |
| `HeaderImage` | string | Path to header image (overrides HeaderText). |
| `description` | string | Site meta description, used on the homepage. |
| `showdate` | bool | Global default for date display. Can be overridden per page. |
| `mainSections` | list | Content types shown on the homepage. Defaults to Hugo's own default. |

---

## Linking between pages

Use relative links in Markdown content:

```markdown
See the [about page](/about) for more.
Read the [first post](/posts/hello-world).
```

For links that should survive if you move content, use Hugo's `relref` shortcode:

```markdown
See the [about page]({{< relref "about" >}}) for more.
```

The theme does not do anything special with links — they render as plain `<a>` tags
and inherit whatever color the browser or the dark-mode stylesheet sets.

---

## Homepage

The homepage (`content/_index.md`) renders a list of post previews pulled from
`mainSections`. Set this in `hugo.toml`:

```toml
[params]
  mainSections = ["posts"]
```

The `_index.md` file can contain content (a lede, an introduction) that renders
above the post list. If it's blank, the list starts immediately.

```markdown
+++
title = "Home"
+++

Welcome. Here's what's been written recently.
```

Set `bigtitle`, `showdate`, and `previewfullcontent` in the `_index.md` front matter
to control how the post list looks.

---

## Content types and sections

Hugo sections map to subdirectories in `content/`. The theme doesn't enforce any
particular structure — use whatever makes sense for your site.

**Recommended minimal structure:**
```
content/
  _index.md          ← homepage
  about.md           ← standalone page
  contact.md         ← standalone page
  posts/
    _index.md        ← post list page
    my-first-post.md
    my-second-post.md
```

**For richer sites**, add more sections:
```
content/
  _index.md
  about.md
  posts/
    _index.md
    ...
  docs/
    _index.md
    getting-started.md
    reference.md
  changelog.md
```

Each section automatically gets a list page at its URL (`/posts/`, `/docs/`) that
shows previews of all content inside it.

---

## The archives section

The theme includes a special `archives` section layout that shows all posts from
`mainSections` in a compact list with dates and tag links. To use it, create
`content/archives/_index.md`:

```markdown
+++
title = "Archive"
+++
```

Add it to your footer menu:

```toml
[[menu.main]]
  title = "Archive"
  url   = "/archives"
  weight = 10
```

This gives readers a chronological index of everything on the site — a useful
complement to the homepage, which typically only shows recent posts.

---

## Tags and taxonomies

Tags are the primary discovery mechanism beyond direct links. Add them to any post:

```markdown
+++
title  = "My Post"
tags   = ["web", "tools", "history"]
+++
```

The theme renders tag links at the bottom of each post and provides a tag index
at `/tags/`. Each tag page lists all posts with that tag.

If you use the `authors` taxonomy, configure it in `hugo.toml`:

```toml
[taxonomies]
  tag    = "tags"
  author = "authors"
```

Then in front matter:

```markdown
authors = ["jane-doe"]
```

Author pages work the same way as tag pages.

---

## Shortcodes

The theme ships with two shortcodes.

### `newsletter-form`

Renders a minimal email signup form. You'll need to fill in the `action` URL and
`list` hidden field to point at your email provider (Buttondown, Mailchimp, etc.).
Edit `layouts/shortcodes/newsletter-form.html` directly.

```markdown
{{< newsletter-form >}}
```

### `show-table`

Renders a JSON data file as an HTML table. Put your data file in `data/` and
reference it by name.

```markdown
{{< show-table table_data="my-table" use_header="true" >}}
```

`data/my-table.json` should be an array of arrays:
```json
[
  ["Name", "Role", "Location"],
  ["Alice", "Engineer", "Berlin"],
  ["Bob", "Designer", "Tokyo"]
]
```

The first row becomes `<th>` headers when `use_header="true"`.

---

## Images

Put images in `static/assets/images/`. Reference them from content with a root
path:

```markdown
![Alt text](/assets/images/my-image.png)
```

Images are constrained to `max-width: 100%` (or `500px` on desktop, matching the
column). They will never overflow the column.

SVG images scale perfectly and have no file size penalty for simple graphics —
prefer SVG for diagrams, logos, and illustrations.

---

## Code and blockquotes

Fenced code blocks render with horizontal scroll for long lines:

````markdown
```python
def hello():
    print("world")
```
````

Blockquotes are slightly indented and rendered in a muted color (slightly lighter
text in both light and dark mode):

```markdown
> This is a pull quote or a citation.
> It can span multiple lines.
```

---

## Dark mode

The theme supports dark mode automatically via `prefers-color-scheme`. No
configuration needed. When a visitor's OS is in dark mode:

- Background becomes `#282828`
- Text becomes `#EEEEEE`
- Links become `#EEEEEE`

You do not need to do anything to support this. If you add custom CSS, be mindful
of any hardcoded colors and add matching `@media (prefers-color-scheme: dark)` rules.

---

## Custom CSS

The theme loads one stylesheet: `/assets/css/style.css`. To add custom styles
without modifying the theme, create a file at the same path in your own site:

```
static/assets/css/style.css
```

Your site's `static/` directory takes precedence over the theme's, so your file
will replace the theme's stylesheet entirely. **Copy the theme CSS first, then
add your overrides below it** — otherwise you lose the base styles.

---

## Information architecture recommendations

Given the theme's single-column, footer-nav model, here is a practical IA pattern
for a content-rich site:

```
Homepage        ← recent posts + brief intro
Posts           ← chronological list of all writing
Archive         ← same content, compact date-indexed view
[Topic pages]   ← tag-driven: /tags/tools, /tags/web, etc.
About           ← who, why
Now             ← what you're working on (nownownow.com style)
Uses / Colophon ← gear and how the site is built
Contact         ← how to reach you
```

Footer menu (suggested order):
```
Home · Posts · Archive · About · Contact
```

Keep the footer to five or six items. Everything else is reachable through tags,
the archive, or inline links in content.

**Do not try to build a hierarchical nav.** The theme has no mechanism for
dropdowns, mega-menus, or nested navigation — and it doesn't need one. A flat
footer and good tagging covers most discovery needs. If a reader can't find
something in two clicks from the homepage, the fix is usually better content
organization, not more navigation chrome.

---

## Installing the theme (Hugo Modules)

In your site's `hugo.toml`:

```toml
[module]
  [[module.imports]]
    path = "github.com/mdashx/basicwebtheme"
```

In your terminal:

```bash
hugo mod init github.com/yourname/yoursite
hugo mod get github.com/mdashx/basicwebtheme
```

To use a local copy (for development):

Add to your site's `go.mod`:
```
replace github.com/mdashx/basicwebtheme => ../basicwebtheme
```

---

## Running the example site

```bash
cd exampleSite
hugo server
```

The `go.work` file at the repo root resolves the theme locally, so no flags or
extra config are needed. Add `--bind 0.0.0.0 --baseURL http://your-ip:1313` if
you need to access it from another device on your network.
