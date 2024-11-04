// 2023-10-09: #fa-icon("fa-info") is not working, so we'll eval "#fa-info()" instead
// 2024-01-29: copied from quarto-cli and revised to use em units
#let callout(
  body: [],
  title: "Callout",
  background_color: rgb("#dddddd"),
  icon: none,
  icon_color: black,
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
        inset: 0.25em,
      )[#text(icon_color, baseline: -0.1em, size: 0.8em, weight: 700)[#icon] #title],
    ) + block(
      inset: 0.25em,
      width: 100%,
      block(fill: white, width: 100%, inset: 0.8em, body),
    ),
  )
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

#let rgb-color(x, default) = {
  if type(x) == array {
    x = default
  }

  if type(x) == color {
    return x
  }

  if x in ("black", "gray", "silver", "white",
              "navy", "blue", "aqua", "teal",
              "eastern", "purple", "maroon", "red",
              "orange", "yellow", "olive", "green", "lime") {
    return eval(x)
  }

  if x.starts-with("\#") {
    x = x.replace("\#", "")
  }

  rgb(x)
}

#let running-text-block(
  font: (),
  fontsize: 10pt,
  fontfill: "black",
  width: 100%,
  inset: 20pt,
  text-align: left,
  content,
) = {
  if content == none {
    return none
  }

  align(text-align, block(
    width: width,
    inset: inset,
    [#text(fill: fontfill, size: fontsize, font: font, content)],
  ))
}

#let typstdoc(

  // Document attributes
  
  title: none,
  subtitle: none,
  authors: none,
  keywords: (),
  date: none,
  abstract: none,
  abstract-title: none,
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

  font: ("Roboto", "Arial", ),
  fontsize: 11pt,
  fontweight: "regular",
  fontfill: "black",
  slashed-zero: false,
  monofont: ("Roboto Mono", "Courier", ),
  
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
  title-align: left,
  title-inset: 0pt,
  
  // Subtitle typography

  subtitle-size: 1.25em,

  // Section numbering

  sectionnumbering: none,
  heading-font: (),
  heading-fontsize: 1.2em,
  heading-fontfill: (),

  // Table of contents

  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  
  lof: false,
  lof_title: "Figures",
  
  lot: false,
  lot_title: "Tables",
  
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
  // list-tight: false,
  // list-spacing: auto,
  
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

  if fill != none {
    fill = rgb-color(fill, "white")
  }

  // Set font fill colors with default
  fontfill = rgb-color(fontfill, "black")
  header-fontfill = rgb-color(header-fontfill, fontfill)
  footer-fontfill = rgb-color(footer-fontfill, fontfill)
  title-fontfill = rgb-color(title-fontfill, fontfill)
  heading-fontfill = rgb-color(heading-fontfill, fontfill)

  // Set document metadata
  set document(title: title, author: names, keywords: keywords,)

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
      fontfill: header-fontfill,
      text-align: header-align,
      header,
    ),
    header-ascent: header-ascent,
    
    // Set footer defaults from other variables
    footer: running-text-block(
      font: ifnone(footer-font, font),
      fontsize: ifnone(footer-fontsize, fontsize),
      fontfill: footer-fontfill,
      text-align: footer-align,
      footer,
    ),
    footer-descent: footer-descent,
  )

  // Set overall text defaults
  
  set text(
    lang: lang,
    region: region,
    font: font,
    weight: fontweight,
    size: fontsize,
    fill: fontfill,
    slashed-zero: slashed-zero,
  )

  // Set font for inline code and blocks
  show raw: set text(font: monofont)

  // Configure heading typography
  set heading(numbering: sectionnumbering)

  show heading: set text(
    font: ifnone(heading-font, font),
    size: ifnone(heading-fontsize, fontsize),
    fill: heading-fontfill,
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
          fill: title-fontfill,
        )[#title]
      ]]
      
     if subtitle != none {
        parbreak()
        text(size: subtitle-size)[#subtitle]
      }
  }

  if authors != none {
    align(title-align)[#block(inset: title-inset)[
        #text()[#author-string]
      ]]
  }

  if date != none {
    align(title-align)[#block(inset: title-inset)[
        #date
      ]]
  }

  if abstract != none {
    if abstract-title == none {
      abstract-title = "$labels.abstract$"
    }
    
    block(inset: title-inset)[
      #text(weight: "semibold")[#abstract-title] #h(0.6em) #abstract
    ]
  }

  // Configure paragraph properties.

  set par(
    justify: justify,
    first-line-indent: first-line-indent,
    hanging-indent: hanging-indent,
    linebreaks: linebreaks,
    leading: leading,
  )

  show par: set block(spacing: spacing)
  
  // Configure table of contents

  if toc {
    let toc_title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 1.5em, below: 3em)[
    #outline(
      title: toc_title,
      depth: toc_depth,
      indent: toc_indent
    );
    ]
  }
  
  // List of figures
  if lof {
     let lof_title = if lof_title == none {
        auto
      } else {
        lof_title
      }
      
    block(above: 1em, below: 2em)[
      #outline(title: lof_title, target: figure.where(kind: "quarto-float-fig"))
    ]
  }
  
  // List of tables
  if lot {
    let lot_title = if lot_title == none {
      auto
    } else {
      lot_title
    }
    
    block(above: 1em, below: 2em)[
      #outline(title: lot_title, target: figure.where(kind: "quarto-float-tbl"))
    ]
  }

  // Configure lists

  set enum(
    indent: list-indent,
    numbering: list-numbering,
    body-indent: list-body-indent,
  )

  set list(
    indent: list-indent,
    // tight: list-tight,
    // spacing: list-spacing,
    body-indent: list-body-indent,
  )

  // Configure columns

  if cols == 1 {
    doc
  } else {
    columns(cols, gutter: (gutter), doc)
  }
}

#set table(
  inset: 6pt,
  stroke: none
)