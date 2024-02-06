// 2023-10-09: #fa-icon("fa-info") is not working, so we'll eval "#fa-info()" instead
// 2024-01-29: copied from quarto-cli and revised to use em units
#let callout(
  body: [],
  title: "Callout",
  background_color: rgb("#dddddd"),
  icon: none,
  icon_color: black
) = {
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

#let ifnone(x, default) = {
  if x == none {
    return default
  }
  
  if x == () {
    return default
  }
  
  x
}


#let ifarray(x, default) = {
  if type(x) == array {
    return default
  }
  
  x
}

#let running-text-block(
  font: (),
  fontsize: 10pt,
  fontfill: luma(0%),
  width: 100%,
  inset: 20pt,
  text-align: left,
  content
) = {
  if content == none {
    return none
  }

  align(
    text-align,
    block(
      width: width,
      inset: inset,
      [#text(fill: fontfill, size: fontsize, font: font, content, )]
    )
  )
}

#let typstdoc(

  // Document attributes
  
  title: none,
  authors: (),
  keywords: (),
  date: auto,
  abstract: none,
  abstract-label: "Abstract",
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
  title-fontsize: 1.5em,
  title-weight: "bold",
  title-fontfill: (),
  title-align: center,
  title-inset: 2em,
  
  // Section numbering

  sectionnumbering: none,
  heading-font: (),
  heading-fontsize: (),
  heading-fontfill: none,

  // Table of contents

  toc: false,
  toc_title: none,
  toc_depth: none,
  
  // Header and footer

  header: none,
  header-font: (),
  header-fontsize: (),
  header-fontfill: (),
  header-align: left,
  header-ascent: 30%,
  
  footer: none,
  footer-font: (),
  footer-fontsize: (),
  footer-fontfill: (),
  footer-align: left,
  footer-descent: 30%,
  
  // List numbering and indent
  
  list-numbering: "1.",
  list-indent: 0pt,
  list-body-indent: 0.5em,
  
  // Bibliography
  
  bibliography-file: none,
  
  // blockquote-fontsize: 11pt,
  
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
    
    // Set header defaults from other variables
    header: running-text-block(
      font: ifnone(header-font, font),
      fontsize: ifnone(header-fontsize, fontsize),
      fontfill: ifarray(header-fontfill, fontfill),
      text-align: ifnone(header-align, title-align),
      footer),
    header-ascent: header-ascent,
    
    // Set footer defaults from other variables
    footer: running-text-block(
      font: ifnone(footer-font, font),
      fontsize: ifnone(footer-fontsize, fontsize),
      fontfill: ifarray(footer-fontfill, fontfill),
      text-align: ifnone(footer-align, title-align),
      footer),
    footer-descent: footer-descent)

  // Set overall text defaults
  
  set text(
    lang: lang,
    region: region,
    font: font,
    weight: fontweight,
    size: fontsize,
    fill: fontfill,
    slashed-zero: slashed-zero)
  
  // Set font for inline code and blocks
  show raw: set text(font: monofont)
    
  // Configure heading typography
  set heading(
    numbering: sectionnumbering)
    
  show heading: set text(
    font: ifnone(heading-font, font),
    size: ifnone(heading-fontsize, fontsize),
    fill: ifnone(heading-fontfill, fontfill)
  )
    
  // Display the bibliography, if supplied
  if bibliography-file != none {
    show bibliography: set text(fontsize * 0.8)
    show bibliography: pad.with(x: fontsize * 0.4)
    bibliography(bibliography-file)
  }

  if title != none {
    align(title-align)[#block(inset: title-inset)[
      #text(
        font: ifnone(title-font, font),
        weight: title-weight,
        size: title-fontsize,
        fill: ifnone(title-fontfill, fontfill)
      )[#title]
    ]]
  }


  if authors != none {
    align(title-align)[#block(inset: title-inset)[
      #text()[#author-string]
    ]]
  }

  if date != none and date != auto {
    align(title-align)[#block(inset: title-inset)[
      #date
    ]]
  }

  if abstract != none {
    block(inset: title-inset)[
      #text(weight: "semibold")[#abstract-label] #h(1em) #abstract
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