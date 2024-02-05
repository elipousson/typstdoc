// 2023-10-09: #fa-icon("fa-info") is not working, so we'll eval "#fa-info()" instead
// 2024-01-29: copied from quarto-cli and revised to use em units
#let callout(body: [], title: "Callout", background_color: rgb("#dddddd"), icon: none, icon_color: black) = {
  block(
    breakable: false,
    fill: background_color,
    stroke: (paint: icon_color, thickness: 0.04em, cap: "round"),
    width: 100%,
    radius: 0.16em,
    block(
      inset: 0.25em,
      width: 100%,
      below: -0.1em,
      block(
        fill: background_color,
        width: 100%,
        inset: 0.25em)[#text(
          icon_color,
          baseline: -0.1em,
          size: 0.8em,
          weight: 700)[#icon] #title]) +
      block(
        inset: 0.25em,
        width: 100%,
        block(fill: white, width: 100%, inset: 0.8em, body)))
}

#let typstdoc(

  // Document attributes
  
  title: none,
  authors: (),
  keywords: (),
  date: auto,
  abstract: none,
  lang: "en",
  region: "US",
  
  // Page layout, fill, and numbering

  paper: "us-letter",
  cols: 1,
  gutter: 4%,
  margin: (x: 1.25in, y: 1.25in),
  flipped: false,
  fill: none,
  page-numbering: "1",
  page-number-align: right + bottom,
  
  // Typography

  font: (),
  fontsize: 11pt,
  fontweight: "regular",
  fontfill: luma(0%),
  slashed-zero: false,
  monofont: ("Courier"),
  
  // Body text typography

  justify: false,
  linebreaks: "optimized",
  first-line-indent: 0pt,
  hanging-indent: 0pt,
  leading: 0.65em,
  spacing: 1.25em,
  
  // Title typography

  title-font: (),
  title-align: center,
  title-size: 1.5em,
  title-inset: 2em,
  title-weight: "bold",
  
  // Section numbering

  sectionnumbering: none,

  // Table of contents

  toc: false,
  toc_title: none,
  toc_depth: none,
  
  // Header and footer

  header: none,
  header-ascent: 30%,
  footer: none,
  footer-descent: 30%,
  
  // List numbering and indent
  
  list-numbering: "1.",
  list-indent: 0pt,
  list-body-indent: 0.5em,
  
  // Bibliography
  
  bibliography-file: none,
  
  doc,
) = {

  // Formats the author's names in a list with commas and a
  // final "and".
  let names = authors.map(author => author.name)
  let author-string = if authors.len() == 2 {
    names.join(" and ")
  } else {
    names.join(", ", last: ", and ")
  }

  // Set document metadata
  set document(
    title: title,
    author: names,
    date: date)

  // Set page layout
  set page(
    paper: paper,
    flipped: flipped,
    margin: margin,
    fill: fill,
    numbering: page-numbering,
    number-align: page-number-align,
    header: header,
    header-ascent: header-ascent,
    footer: footer,
    footer-descent: footer-descent)

  set text(
    lang: lang,
    region: region,
    font: font,
    weight: fontweight,
    size: fontsize,
    fill: fontfill,
    slashed-zero: slashed-zero)
  
  show raw: set text(font: monofont)
    
  set heading(
    numbering: sectionnumbering)
    
  // Display the bibliography, if supplied
  if bibliography-file != none {
    show bibliography: set text(fontsize * 0.8)
    show bibliography: pad.with(x: fontsize * 0.4)
    bibliography(bibliography-file)
  }

  if title != none {
    align(title-align)[#block(inset: title-inset)[
      #text(font: title-font, weight: title-weight, size: title-size)[#title]
    ]]
  }

  if authors != none {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      ..authors.map(author =>
          align(title-align)[
            #author.name \
            #author.affiliation \
            #author.email
          ]
      )
    )
  }

  if date != none and date != auto {
    align(title-align)[#block(inset: title-size * 0.5)[
      #date
    ]]
  }

  if abstract != none {
    block(inset: title-inset)[
    #text(weight: "semibold")[Abstract] #h(title-size * 0.5) #abstract
    ]
  }
  
  // Configure paragraph properties.
    
  set par(
    justify: justify,
    first-line-indent: first-line-indent,
    hanging-indent: hanging-indent,
    linebreaks: linebreaks,
    leading: leading)

  show par: set block(spacing: spacing)

  // Configure table of contents
  
  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth
    );
    ]
  }

  // Configure lists
  
  set enum(
    indent: list-indent,
    numbering: list-numbering,
    body-indent: list-body-indent)

  set list(
    indent: list-indent,
    body-indent: list-body-indent)
  
  // Configure columns
  
  if cols == 1 {
    doc
  } else {
    columns(cols, gutter: (gutter), doc)
  }
}
