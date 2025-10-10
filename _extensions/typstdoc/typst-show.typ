// https://github.com/quarto-dev/quarto-cli/blob/main/src/resources/formats/typst/pandoc/quarto/typst-show.typ
#show: doc => typstdoc(
// Document attributes
$if(title)$
  title: [$title$],
$endif$
$if(subtitle)$
  subtitle: [$subtitle$],
$endif$
$if(by-author)$
  authors: (
  $for(by-author)$
  $if(it.name.literal)$
      ( name: "$it.name.literal$",
        affiliation: [$for(it.affiliations)$$it.name$$sep$, $endfor$],
        email: [$it.email$] ),
  $endif$
  $endfor$
      ),
$endif$
// TODO: Add support for keywords
// $if(keywords)$
//  keywords: ($for(keywords)$$keyword$$sep$,$endfor$),
// $endif$
$if(date)$
  date: [$date$],
$endif$
$if(lang)$
  lang: "$lang$",
$endif$
$if(region)$
  region: "$region$",
$endif$
$if(abstract)$
  abstract: [$abstract$],
  $if(abstract-label)$
  abstract-title: "$abstract-label$",
  $else$
  abstract-title: "$labels.abstract$",
  $endif$
$endif$

// Page layout, fill, and numbering

// TODO: Consider removing page parameters to match main template
// https://github.com/quarto-dev/quarto-cli/commit/75fbfd091caf62fb68bbf299db5c95c99bc60f00
$if(papersize)$
  paper: "$papersize$",
$endif$
$if(margin)$
  margin: ($for(margin/pairs)$$margin.key$: $margin.value$,$endfor$),
$endif$
$if(papersize)$
  paper: "$papersize$",
$endif$
$if(flipped)$
  flipped: $flipped$,
$endif$
cols: $if(columns)$$columns$$else$1$endif$, // Columns
$if(gutter)$
  gutter: $gutter$,
$endif$
$if(fill)$
  fill: "$fill$",
$endif$
$if(page-numbering)$
  page-numbering: "$page-numbering$",
$endif$
$if(page-number-align)$
  page-number-align: $page-number-align$,
$endif$

// Typography

$if(mainfont)$
  font: ("$mainfont$",),
$elseif(brand.typography.base.family)$
  font: ("$brand.typography.base.family$",),
$endif$
$if(monofont)$
  monospace-family: ("$monofont$",),
$elseif(monospace-family)$
  monospace-family: ("$monospace-family$",),
$elseif(brand.typography.monospace.family)$
  monospace-family: $brand.typography.monospace.family$,
$endif$
$if(fontsize)$
  fontsize: $fontsize$,
$elseif(brand.typography.base.size)$
  fontsize: $brand.typography.base.size$,
$endif$
$if(fontweight)$
  fontweight: $fontweight$,
$endif$
$if(fontfill)$
  fontfill: "$fontfill$",
$elseif(brand.typography.base.color)$
  fontfill: $brand.typography.base.color$,
$endif$
$if(slashed-zero)$
  slashed-zero: $slashed-zero$,
$endif$

// Body text typography

$if(justify)$
  justify: $justify$,
$endif$
$if(linebreaks)$
  linebreaks: "$linebreaks$",
$endif$
$if(first-line-indent)$
  first-line-indent: $first-line-indent$,
$endif$
$if(hanging-indent)$
  hanging-indent: $hanging-indent$,
$endif$
$if(leading)$
  leading: $leading$,
$endif$
$if(spacing)$
  spacing: $spacing$,
$endif$

// Title typography

$if(title-font)$
  title-font: ("$title-font$",),
$endif$
$if(title-fontfill)$
  title-fontfill: "$title-fontfill$",
$endif$
$if(title-align)$
  title-align: $title-align$,
$endif$
$if(title-fontsize)$
  title-fontsize: $title-fontsize$,
$endif$
$if(title-inset)$
  title-inset: $title-inset$,
$endif$
$if(title-weight)$
  title-weight: "$title-weight$",
$endif$

// Section numbering

$if(section-numbering)$
  sectionnumbering: "$section-numbering$",
$endif$

$if(heading-family)$
  heading-family: ("$heading-family$",),
$elseif(brand.typography.headings.family)$
  heading-family: $brand.typography.headings.family$,
$elseif(heading-font)$
  heading-family: ("$heading-font$",),
$endif$
$if(brand.typography.headings.weight)$
  heading-weight: $brand.typography.headings.weight$,
$endif$
$if(heading-style)$
  heading-style: "$heading-style$",
$elseif(brand.typography.headings.style)$
  heading-style: "$brand.typography.headings.style$",
$endif$
$if(heading-color)$
  heading-color: "$heading-color$",
$elseif(brand.typography.headings.color)$
  heading-color: $brand.typography.headings.color$,
$elseif(heading-fontfill)$
  heading-color: "$heading-fontfill$",
$endif$
$if(brand.typography.headings.line-height)$
  heading-line-height: $brand.typography.headings.line-height$,
$endif$
$if(heading-fontsize)$
  heading-fontsize: $heading-fontsize$,
$elseif(brand.typography.headings.size)$
  heading-fontsize: $brand.typography.headings.size$,
$endif$

// Table of contents

$if(toc)$
  toc: $toc$,
$endif$
$if(toc-title)$
  toc_title: [$toc-title$],
$endif$
$if(toc-indent)$
  toc_indent: $toc-indent$,
$endif$
  toc_depth: $toc-depth$,

// List of figures

$if(lof)$
  lof: $lof$,
$endif$
$if(lof-title)$
  lof_title: [$lof-title$],
$endif$

// List of tables

$if(lot)$
  lot: $lot$,
$endif$
$if(lot-title)$
  lot_title: [$lot-title$],
$endif$

// Header and footer

$if(header)$
  header: [$header$],
$endif$
$if(header-fontfill)$
  header-fontfill: "$header-fontfill$",
$endif$
$if(header-fontsize)$
  header-fontsize: $header-fontsize$,
$endif$
$if(header-align)$
  header-align: [$header-align$],
$endif$
$if(header-ascent)$
  header-ascent: $header-ascent$,
$endif$
$if(footer)$
  footer: [$footer$],
$endif$
$if(footer-fontfill)$
  footer-fontfill: "$footer-fontfill$",
$endif$
$if(footer-fontsize)$
  footer-fontsize: $footer-fontsize$,
$endif$
$if(footer-align)$
  footer-align: [$footer-align$],
$endif$
$if(footer-descent)$
  footer-descent: $footer-descent$,
$endif$

// List numbering and indent

$if(list-numbering)$
  list-numbering: "$list-numbering$",
$endif$
$if(list-indent)$
  list-indent: $list-indent$,
$endif$
$if(list-body-indent)$
  list-body-indent: $list-body-indent$,
$endif$
// List tight and list spacing
// $if(list-tight)$
//   list-tight: $list-tight$,
// $endif$
// $if(list-spacing)$
//   list-spacing: $list-spacing$,
// $endif$

// Bibliography

$if(bibliography)$
  bibliography-file: "$bibliography$",
$endif$

$if(blockquote-fontsize)$
  blockquote-fontsize: $blockquote-fontsize$,
$endif$

  doc,
)
