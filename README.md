# typstdoc Format

## Installing typstdoc

```bash
quarto use template elipousson/typstdoc
```

This will install the format extension and create an example qmd file
that you can use as a starting place for your document.

## Using typstdoc

This format extends the existing typst template with more complete coverage of the possible parameters for [page](https://typst.app/docs/reference/layout/page/), [text](https://typst.app/docs/reference/text/text/), [par](https://typst.app/docs/reference/model/par/). These additional parameters allow more fine-grained control over the typography and appearance of the document.

The format also overrides the standard template for callouts by converting units from `pt` to `em` to ensure that the size of the border and padding around the callout text is appropriate when using a large `papersize`.

- text
  - fontfill
  - fontweight
  - spacing
  - slashed-zero
  - leading
- par
  - justify
  - first-line-indent
  - hanging-indent
  - linebreaks
  - leading
- page
  - fill
  - numbering
  - number-align
  
The header and footer parameters are not currently working. Support for custom list formatting will be added soon. 

This format is published under the [CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/) public domain license.

