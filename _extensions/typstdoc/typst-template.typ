// 2023-10-09: #fa-icon("fa-info") is not working, so we'll eval "#fa-info()" instead
// 2024-01-29: copied from quarto-cli and revised to use em units
// 2025-10-21: updated to use new body_background_color argument
// 2026-03-14: updated to use updated icon handling
// See https://github.com/quarto-dev/quarto-cli/blob/main/src/resources/formats/typst/pandoc/quarto/definitions.typ
#let callout(
  body: [],
  title: "Callout",
  background_color: rgb("#dddddd"),
  icon: none,
  icon_color: black,
  body_background_color: white,
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
      )[#if icon != none [#text(icon_color, size: 0.8em, weight: 900)[#icon] ]#title]) +
      if(body != []){
        block(
          inset: 0.25em,
          width: 100%,
          block(fill: body_background_color, width: 100%, inset: 0.8em, body)
        )
      }
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

  if (
    x
      in (
        "black",
        "gray",
        "silver",
        "white",
        "navy",
        "blue",
        "aqua",
        "teal",
        "eastern",
        "purple",
        "fuchsia",
        "maroon",
        "red",
        "orange",
        "yellow",
        "olive",
        "green",
        "lime",
      )
  ) {
    return eval(x)
  }

  if x.starts-with("\#") {
    x = x.replace("\#", "")
  }

  rgb(x)
}

// Convert content to a plain string, e.g. for PDF metadata. Unlike Quarto's
// content-to-string(), this keeps smart quotes.
#let plain-text(it) = {
  if it == none {
    ""
  } else if type(it) == str {
    it
  } else if it.has("text") {
    it.text
  } else if it.has("children") {
    it.children.map(plain-text).join()
  } else if it.has("body") {
    plain-text(it.body)
  } else if it.func() == smartquote {
    if it.at("double", default: true) { "\"" } else { "'" }
  } else if it == [ ] {
    " "
  } else {
    ""
  }
}

// Normalize a font option to an array of font families. Accepts one family,
// a comma-separated string of fallbacks ("Roboto, Arial"), or an array.
#let font-list(x) = {
  if x == none or x == auto {
    return x
  }

  let fonts = if type(x) == array { x } else { (x,) }
  fonts
    .map(f => if type(f) == str { f.split(",").map(str.trim) } else { (f,) })
    .flatten()
    .filter(f => f != "")
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
    return auto
  }

  align(text-align, block(
    width: width,
    inset: inset,
    [#text(fill: fontfill, size: fontsize, font: font, content)],
  ))
}

// Container for a definition list (added by terms.lua). Quarto's
// definitions.typ has a `show terms.item` rule that turns items written as
// markup into plain blocks, which drops the list's PDF tags (L/LI/Lbl/LBody)
// and ignores `set terms` rules. Rebuilding the items into an explicit
// `terms()` call keeps the native layout and tagging. Each term is labelled so
// typstdoc() can style it, and `strong` is switched off for the term so
// `term-weight` sets the final weight. Block spacing at the start and end of a
// container is dropped, so the list keeps paragraph spacing from surrounding
// text.
#let typstdoc-terms(body) = context {
  // Each term is a sticky block so it stays on the same page as its
  // definition. The separator and hanging indent from `set terms` are applied
  // here because a block term takes them out of the native layout.
  let separator = terms.separator
  let hanging-indent = terms.hanging-indent

  let children = if body.has("children") { body.children } else { (body,) }
  let items = children
    .filter(child => child.func() == terms.item)
    .map(item => {
      // Pandoc wraps each definition in a block; use line spacing rather than
      // paragraph spacing between it and the term
      let description = item.description
      if description.func() == block {
        let fields = description.fields()
        let body = fields.remove("body", default: none)
        description = block(..fields, above: par.leading, inset: (left: hanging-indent), body)
      } else {
        description = block(above: par.leading, inset: (left: hanging-indent), description)
      }

      terms.item(
        block(sticky: true)[#[#item.term]<typstdoc-term>#separator],
        [#set strong(delta: 300); #description],
      )
    })

  block(above: par.spacing, below: par.spacing, {
    set strong(delta: 0)
    set terms(separator: [], hanging-indent: 0pt)
    terms(..items)
  })
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
  thanks: none,
  lang: "en",
  region: "US",

  // Typography

  font: ("Roboto", "Arial", ),
  fontsize: 11pt,
  fontweight: "regular",
  fontfill: "black",
  slashed-zero: false,
  monospace-family: ("Roboto Mono", "Courier", ),
  mathfont: none,
  linestretch: none,
  citecolor: none,
  filecolor: none,

  // Body text typography
  justify: false,
  linebreaks: "optimized",
  first-line-indent: 0pt,
  hanging-indent: 0pt,
  leading: 0.65em,
  spacing: 1.25em,

  // Heading typography
  heading-family: (),
  heading-fontsize: 1.2em,
  heading-weight: "bold",
  heading-style: "normal",
  heading-color: (),
  heading-line-height: 0.65em,

  // Link typography
  link-family: (),
  linkcolor: none,
  // link-color: none,

  // Title typography

  title-family: (),
  title-size: 1.5em,
  title-weight: "bold",
  title-color: (),
  title-align: left,
  title-inset: 0pt,

  // Subtitle typography

  subtitle-size: 1.25em,

  // Section numbering

  sectionnumbering: none,

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
  header-color: (),
  header-align: left,
  header-ascent: 30%,

  footer: none,
  footer-font: (),
  footer-fontsize: (),
  footer-color: (),
  footer-align: left,
  footer-descent: 30%,

  // Term (definition) lists

  terms-tight: true,
  terms-indent: 0pt,
  terms-hanging-indent: 1.5em,
  terms-spacing: auto,
  terms-separator: none,
  term-color: (),
  term-weight: "bold",

  // List numbering and indent

  list-numbering: "1.",
  list-indent: 0pt,
  list-body-indent: 0.5em,
  // list-tight: false,
  // list-spacing: auto,

  // Block quotes

  blockquote-fontsize: none,

  doc,
) = {
  // Format author names in a list with commas and a final "and".
  let names = ()
  let author-string = none

  if authors != none {
    names = authors.map(author => author.name)
    author-string = if authors.len() == 2 {
      names.join(" and ")
    } else {
      names.join(", ", last: ", and ")
    }
  }

  // Set document metadata
  set document(
    title: title,
    author: names.map(plain-text),
    description: abstract,
    keywords: keywords,
  )

  // Normalize font options to arrays of fallback families
  font = font-list(font)
  monospace-family = font-list(monospace-family)
  mathfont = font-list(mathfont)
  heading-family = font-list(heading-family)
  title-family = font-list(title-family)
  link-family = font-list(link-family)
  header-font = font-list(header-font)
  footer-font = font-list(footer-font)

  // Set font fill colors with default
  fontfill = rgb-color(fontfill, "black")
  header-color = rgb-color(header-color, fontfill)
  footer-color = rgb-color(footer-color, fontfill)

  heading-color = rgb-color(heading-color, fontfill)

  // Set header and footer
  set page(
    // Set header defaults from other variables
    header: running-text-block(
      font: ifnone(header-font, font),
      fontsize: ifnone(header-fontsize, fontsize),
      fontfill: header-color,
      text-align: header-align,
      header,
    ),

    // Set footer defaults from other variables
    footer: running-text-block(
      font: ifnone(footer-font, font),
      fontsize: ifnone(footer-fontsize, fontsize),
      fontfill: footer-color,
      text-align: footer-align,
      footer,
    ),
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
  show raw: set text(font: monospace-family) if monospace-family != none
  show math.equation: set text(font: mathfont) if mathfont != none

  // Set heading typography
  set heading(numbering: sectionnumbering)

  heading-family = ifnone(heading-family, font)

  show heading: set text(
    font: heading-family,
    size: ifnone(heading-fontsize, fontsize),
    fill: heading-color,
    weight: heading-weight,
    style: heading-style,
  )

  show heading: set par(leading: heading-line-height)

  // Set link typography. `filecolor` applies to links to labels within the
  // document (as in Quarto's default template) and `linkcolor` to all others.
  show link: set text(font: link-family) if link-family != ()
  show link: it => {
    let link-fill = if filecolor != none and type(it.dest) == label {
      filecolor
    } else {
      linkcolor
    }
    if link-fill == none { return it }
    set text(fill: rgb-color(link-fill, fontfill))
    it
  }
  show ref: set text(fill: rgb-color(citecolor, fontfill)) if citecolor != none

  // Set block quote typography
  show quote.where(block: true): set text(size: blockquote-fontsize) if blockquote-fontsize != none

  // Show title, subtitle, and thanks (if title supplied)
  if title != none {
    align(title-align)[#block(inset: title-inset)[
      #set par(leading: heading-line-height)
      #set text(
        font: ifnone(title-family, heading-family),
        fill: rgb-color(title-color, heading-color),
      )
      #text(weight: title-weight, size: title-size)[#title]#if thanks != none {
        footnote(thanks, numbering: "*")
        counter(footnote).update(n => n - 1)
      }
      #if subtitle != none {
        parbreak()
        text(size: subtitle-size)[#subtitle]
      }
    ]]
  }

  // Show authors, date, and abstract
  if authors != none {
    align(title-align)[#block(inset: title-inset)[
      #author-string
    ]]
  }

  if date != none {
    align(title-align)[#block(inset: title-inset)[
      #date
    ]]
  }

  if abstract != none {
    block(inset: title-inset)[
      #text(weight: "semibold")[#abstract-title] #h(0.5em) #abstract
    ]
  }

  // Configure paragraph properties.

  set par(
    justify: justify,
    first-line-indent: first-line-indent,
    hanging-indent: hanging-indent,
    linebreaks: linebreaks,
    // linestretch scales the default leading, as in Quarto's default template
    leading: if linestretch != none { linestretch * 0.65em } else { leading },
    spacing: spacing,
  )

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
        indent: toc_indent,
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

  // Configure term (definition) lists; see typstdoc-terms() above
  set terms(
    tight: terms-tight,
    indent: terms-indent,
    hanging-indent: terms-hanging-indent,
    spacing: terms-spacing,
  )
  set terms(separator: terms-separator) if terms-separator != none
  show <typstdoc-term>: set text(
    fill: rgb-color(term-color, fontfill),
    weight: term-weight,
  )

  doc
}

#set table(
  inset: 6pt,
  stroke: none
)
