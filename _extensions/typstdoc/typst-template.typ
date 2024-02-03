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
      inset: 0.24em,
      width: 100%,
      below: 0pt,
      block(
        fill: background_color,
        width: 100%,
        inset: 0.25em)[#text(icon_color, baseline: -0.1em, size: 0.8em, weight: 700)[#icon] #title]) +
      block(
        inset: 0.25em,
        width: 100%,
        block(fill: white, width: 100%, inset: 0.8em, body)))
}

#let document(
  title: none,
  authors: none,
  date: none,
  abstract: none,
  cols: 1,
  gutter: 4%,
  margin: (x: 1.25in, y: 1.25in),
  paper: "us-letter",
  flipped: false,
  fill: none,
  lang: "en",
  region: "US",
  justify: false,
  linebreaks: "optimized",
  first-line-indent: 0pt,
  hanging-indent: 0pt,
  leading: 0.65em,
  font: (),
  fontsize: 11pt,
  fontweight: "regular",
  spacing: 3em,
  fontfill: luma(0%),
  slashed-zero: true,
  numbering: "1",
  number-align: center + bottom,
  sectionnumbering: none,
  header: none,
  header-ascent: 30%,
  footer: none,
  footer-descent: 30%,
  toc: false,
  toc_title: none,
  toc_depth: none,
  doc,
) = {

  set page(
    paper: paper,
    flipped: flipped,
    margin: margin,
    fill: fill,
    numbering: numbering,
    number-align: number-align,
    header: header,
    header-ascent: header-ascent,
    footer: footer,
    footer-descent: footer-descent)

  set par(
    justify: justify,
    first-line-indent: first-line-indent,
    hanging-indent: hanging-indent,
    linebreaks: linebreaks,
    leading: leading)

  set text(
    lang: lang,
    region: region,
    font: font,
    weight: fontweight,
    size: fontsize,
    fill: fontfill,
    slashed-zero: slashed-zero)
    
  set heading(numbering: sectionnumbering)

  if title != none {
    align(center)[#block(inset: 2em)[
      #text(weight: "bold", size: 1.5em)[#title]
    ]]
  }

  if authors != none {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      ..authors.map(author =>
          align(center)[
            #author.name \
            #author.affiliation \
            #author.email
          ]
      )
    )
  }

  if date != none {
    align(center)[#block(inset: 1em)[
      #date
    ]]
  }

  if abstract != none {
    block(inset: 2em)[
    #text(weight: "semibold")[Abstract] #h(1em) #abstract
    ]
  }

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

  show: columns.with(cols, gutter: (gutter))
  // show par: set block(spacing: (spacing), breakable: false)

  doc
}
