+++
title = "Shortcodes"
date = 2026-01-07T00:00:00Z
draft = false
tags = ["reference", "content"]
SubTitle = "Two built-in shortcodes: a newsletter form and a data table."
+++

The theme ships with two shortcodes. Hugo also provides its own built-in shortcodes for things like YouTube embeds — see the [Hugo docs](https://gohugo.io/content-management/shortcodes/) for those.

### newsletter-form

Renders a minimal email signup form with a spam-trap hidden field.

```
{{</* newsletter-form */>}}
```

Before using it, edit `layouts/shortcodes/newsletter-form.html` (in your own site, not the theme) to fill in the `action` URL and `list` hidden field value from your email provider (Buttondown, Mailchimp, ConvertKit, etc.).

The form is intentionally unstyled beyond the base CSS — one text input, one submit button.

### show-table

Renders a JSON data file from your `data/` directory as an HTML table.

```
{{</* show-table table_data="pricing" use_header="true" */>}}
```

**Parameters:**

| Param | Required | Description |
|-------|----------|-------------|
| `table_data` | yes | Filename (without `.json`) of a file in `data/` |
| `use_header` | no | If `"true"`, the first row becomes `<th>` header cells |
| `classes` | no | CSS class(es) added to the `<table>` element |

**Data file format** — an array of arrays in `data/pricing.json`:

```json
[
  ["Plan", "Price", "Storage", "Users"],
  ["Free", "$0/mo", "5 GB", "1"],
  ["Pro", "$12/mo", "50 GB", "5"],
  ["Team", "$49/mo", "500 GB", "Unlimited"]
]
```

The first row becomes headers when `use_header="true"`.

**Example output with the data above:**

{{< show-table table_data="example-table" use_header="true" >}}
