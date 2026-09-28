# typstdoc Format

## Installing typstdoc

```bash
quarto use template elipousson/typstdoc
```

This will install the format extension and create an example qmd file
that you can use as a starting place for your document.

To skip the template (which is only just intendended as an example):

```bash
quarto add elipousson/typstdoc
```

## Using typstdoc

This format extends the existing typst template with more complete coverage of settable parameters for the `page`, `text`, and `par` Typst elements:

- [`page`](https://typst.app/docs/reference/layout/page/)
  - `paper` (set by `papersize`)
  - `flipped`
  - `margin`
  - `fill`
  - `numbering` (set by `page-numbering`)
  - `number-align` (set by `page-number-align`)
  - `header`
  - `header-ascent`
  - `footer`
  - `footer-descent`
- [`text`](https://typst.app/docs/reference/text/text/)
  - `font` (set by `mainfont`)
  - `weight` (set by `fontweight`)
  - `spacing` (set as a default property of `par` blocks)
  - `slashed-zero`
- [`par`](https://typst.app/docs/reference/model/par/)
  - `justify`
  - `first-line-indent`
  - `hanging-indent`
  - `linebreaks`
  - `leading` (ignored if `linestretch` is supplied; see [Line spacing](#line-spacing))

These additional parameters allow more fine-grained control over the typography and appearance of the document. You can set the font, size, and fill for the headings (using `heading-font`, `heading-color`, etc.) and font, weight, and size for the title (using `title-font`, `title-weight`, etc.).

You can custom the color of the main body, heading, title, footer, and header text using the fill parameters.  By default, these elements all inherit the main font fill.

This format includes experimental support for a listing of figures (set `lof: true`) which mostly works and a listing of tables (set `lot: true`) which mostly doesn't work.

This format supports hex color strings (with or without a hash symbol at the start of the string) and standard Typst color names (see [color](https://typst.app/docs/reference/visualize/color/) for documentation). Both quoted and unquoted fill parameters are allowed as the following example shows:

```yaml
---
format:
  typstdoc-typst:
    title: "Typst Document Title"
    heading-color: blue
    title-color: "#0074d9"
    footer: "This is a custom footer"
    footer-color: 0074d9
---
```

You can also set the font, size, fill, and align for the header and footer and provide custom text for the header or footer. Note the page number will be suppressed if `page-number-align` is set to `bottom` when footer is supplied or `top` when header is supplied.

```yaml
---
title: "My Paper"
author: Janet Doe
format:
  typstdoc-typst:
    mainfont: "Roboto"
    fontsize: 18pt
    leading: 12pt
    heading-font: "Roboto Narrow"
    heading-color: blue
    codefont: "Roboto Code"
---
```

### Fonts

Every font option accepts a single font or a comma-separated list of fallback fonts. Typst uses the first font in the list that is installed and falls back to the next one for any missing characters. The typstdoc-specific font options also accept a YAML list, but Quarto only allows a single string for `mainfont`, `codefont`, `monofont`, and `mathfont`, so use commas for those.

| Option | Default | Applies to |
|---|---|---|
| `mainfont` | `"Roboto, Arial"` | Body text, and any element without its own font |
| `codefont` (or `monofont`, `monospace-family`) | `"Roboto Mono, Courier"` | Inline code and code blocks |
| `mathfont` | Typst default | Equations |
| `heading-family` (or `heading-font`) | `mainfont` | Headings |
| `title-family` (or `title-font`) | Heading font | Title and subtitle |
| `link-family` | `mainfont` | Links |
| `header-font` | `mainfont` | Custom header text |
| `footer-font` | `mainfont` | Custom footer text |

```yaml
---
format:
  typstdoc-typst:
    mainfont: "Source Sans 3, Roboto, Arial"
    codefont: "Fira Code, DejaVu Sans Mono"
    heading-family: [Source Serif 4, Libertinus Serif]
    link-family: "DejaVu Sans Mono"
---
```

Fonts set with `_brand.yml` (`brand.typography`) are used for the base, heading, monospace, math, and link fonts when the matching option isn't set.

### Line spacing

Set `linestretch` to scale the line spacing of body text relative to the default (`0.65em`), as in Quarto's default Typst format: `linestretch: 1.5` gives one-and-a-half spacing. To set an exact value instead, use `leading` (ignored when `linestretch` is set). `spacing` sets the space between paragraphs (default `1.25em`).

Use `heading-line-height` (default `0.65em`) to set the line spacing for headings and the title block when they wrap onto more than one line.

### Title block

The title, subtitle, author names, date, and abstract are placed at the top of the first page. The subtitle uses the same alignment, font, and color as the title at `subtitle-size` (default `1.25em`). Set `thanks` to add an acknowledgment as a `*` footnote on the title; it doesn't affect the numbering of other footnotes.

```yaml
---
title: "My Paper"
subtitle: "A Working Draft"
thanks: "Supported by the Example Foundation."
author:
  - Janet Doe
  - Sam Roe
format:
  typstdoc-typst:
    title-align: center
    title-color: "#1f5c99"
    title-size: 2em
    title-weight: semibold
    heading-line-height: 1.2em
---
```

Author names can include quotes or other special characters, and are added to the PDF metadata along with the title, abstract (as the description), and `keywords`.

### Links

| Option | Default | Description |
|---|---|---|
| `linkcolor` (or `link-color`) | text color | Color of links, or `brand.color.primary` if set |
| `filecolor` | `linkcolor` | Color of links to a location within the document, e.g. `[see above](#sec-intro)` |
| `citecolor` | text color | Color of cross-references, e.g. `@sec-intro` |
| `link-family` | `mainfont` | Font for links |

Colors can be hex strings or Typst color names.

### Block quotes

Set `blockquote-fontsize` (e.g. `0.9em` or `9pt`) to change the text size of block quotes.

### Page numbers

Pages are numbered by default using `page-numbering` (default `"1"`). Set `page-numbering: false` to turn off page numbers. A custom `header` or `footer` replaces the default page number in that position.

### Definition lists

Definition lists (a term followed by one or more `:` definition lines) are laid out using the Typst [`terms`](https://typst.app/docs/reference/model/terms/) element, which you can customize with these options:

| Option | Default | Description |
|---|---|---|
| `terms-tight` | `true` | Space items using line spacing (`true`) or paragraph spacing (`false`) |
| `terms-spacing` | `auto` | Spacing between items; overrides `terms-tight` |
| `terms-indent` | `0pt` | Indent for the whole list |
| `terms-hanging-indent` | `1.5em` | Indent for each definition below its term |
| `terms-separator` | none | Text placed after each term, e.g. `":"` |
| `term-color` | main font fill | Term color (hex string or Typst color name) |
| `term-weight` | `bold` | Term font weight |

```yaml
---
format:
  typstdoc-typst:
    terms-tight: false
    terms-spacing: 1.5em
    terms-indent: 1em
    terms-hanging-indent: 3em
    terms-separator: "—"
    term-color: maroon
    term-weight: regular
---
```

Each definition starts on the line below its term. A definition with more than one paragraph needs a blank line between the term and the `:` line, otherwise Pandoc joins the paragraphs together. Pandoc also removes leading spaces from `terms-separator`.

Unlike the default Quarto Typst format, definition lists keep their list structure in the tagged PDF, so screen readers can identify each term and its definition.

See `terms-compact.qmd` and `terms-spaced.qmd` for two complete examples.

The format also overrides the standard template for callouts by converting units from `pt` to `em` to ensure that the size of the border and padding around the callout text is appropriate when using a large `papersize`. While main font defaults to a point size value (11pt), the other font sizes are set using em units to allow everything to scale to match the main `fontsize` value.

This format is published under the [CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/) public domain license.
