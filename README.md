# typstdoc Format

## Installing typstdoc

```bash
quarto use template elipousson/typstdoc
```

This will install the format extension and create an example qmd file
that you can use as a starting place for your document.

## Using typstdoc

This format extends the existing typst template with more complete coverage of the possible parameters for [page](https://typst.app/docs/reference/layout/page/), [text](https://typst.app/docs/reference/text/text/), [par](https://typst.app/docs/reference/model/par/).

Supported parameters for these functions include:

- page
  - paper
  - flipped
  - margin
  - fill
  - numbering (set by page-numbering)
  - number-align (set by page-number-align)
  - header
  - header-ascent
  - footer
  - footer-descent
- text
  - font
  - fill (set by fontfill)
  - weight (set by fontweight)
  - spacing
  - slashed-zero
- par
  - justify
  - first-line-indent
  - hanging-indent
  - linebreaks
  - leading
  
These additional parameters allow more fine-grained control over the typography and appearance of the document. You can set the font, size, and fill for the headings (using `heading-font`, `heading-fontfill`, etc.) and font, weight, and size for the title (using `title-font`, `title-fontweight`, etc.).

You can custom the color of the main body, heading, title, footer, and header text using the fill parameters.  By default, these elements all inherit the font fill.

This format supports hex color strings (with or without a hash symbol at the start of the string) and standard Typst color names (see [color](https://typst.app/docs/reference/visualize/color/) for documentation). Both quoted and unquoted fill parameters are allowed as the following example shows:

```yaml
---
format:
  typstdoc-typst:
    title: "Typst Document Title"
    heading-fontfill: blue
    title-fontfill: "#0074d9"
    footer: "This is a custom footer"
    footer-fontfill: 0074d9
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
    heading-fontfill: blue
    hex-fill: true
    monofont: "Roboto Code"
---
```

The format also overrides the standard template for callouts by converting units from `pt` to `em` to ensure that the size of the border and padding around the callout text is appropriate when using a large `papersize`. While main font defaults to a point size value (11pt), the other font sizes are set using em units to allow everything to scale to match the main `fontsize` value.

This format is published under the [CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/) public domain license.
