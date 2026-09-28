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
      ( name: [$it.name.literal$],
        affiliation: [$for(it.affiliations)$$it.name$$sep$, $endfor$],
        email: [$it.email$] ),
  $endif$
  $endfor$
      ),
$endif$
// TODO: Add support for keywords
$if(keywords)$
  keywords: ($for(keywords)$"$keywords$",$endfor$),
$endif$
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
$if(thanks)$
  thanks: [$thanks$],
$endif$

// Typography

$if(mainfont)$
  font: ($for(mainfont)$"$mainfont$",$endfor$),
$elseif(brand.typography.base.family)$
  font: $brand.typography.base.family$,
$endif$
$if(codefont)$
  monospace-family: ($for(codefont)$"$codefont$",$endfor$),
$elseif(monofont)$
  monospace-family: ($for(monofont)$"$monofont$",$endfor$),
$elseif(monospace-family)$
  monospace-family: ($for(monospace-family)$"$monospace-family$",$endfor$),
$elseif(brand.typography.monospace.family)$
  monospace-family: $brand.typography.monospace.family$,
$endif$
$if(mathfont)$
  mathfont: ($for(mathfont)$"$mathfont$",$endfor$),
$elseif(brand.typography.math.family)$
  mathfont: $brand.typography.math.family$,
$endif$
$if(fontsize)$
  fontsize: $fontsize$,
$elseif(brand.typography.base.size)$
  fontsize: $brand.typography.base.size$,
$endif$
$if(fontweight)$
  fontweight: $fontweight$,
$elseif(brand.typography.base.weight)$
  fontweight: $brand.typography.base.weight$,
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
// Set linestretch *or* leading
$if(linestretch)$
  linestretch: $linestretch$,
$elseif(leading)$
  leading: $leading$,
$endif$
$if(spacing)$
  spacing: $spacing$,
$endif$

// Title typography

$if(title-family)$
  title-family: ($for(title-family)$"$title-family$",$endfor$),
$elseif(title-font)$
  title-family: ($for(title-font)$"$title-font$",$endfor$),
$endif$
$if(title-color)$
  title-color: "$title-color$",
$elseif(title-fontfill)$
  title-color: "$title-fontfill$",
$endif$
$if(title-align)$
  title-align: $title-align$,
$endif$
$if(title-size)$
  title-size: $title-size$,
$elseif(title-fontsize)$
  title-size: $title-fontsize$,
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
  heading-family: ($for(heading-family)$"$heading-family$",$endfor$),
$elseif(heading-font)$
  heading-family: ($for(heading-font)$"$heading-font$",$endfor$),
$elseif(brand.typography.headings.family)$
  heading-family: $brand.typography.headings.family$,
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
$if(heading-line-height)$
  heading-line-height: $heading-line-height$,
$elseif(brand.typography.headings.line-height)$
  heading-line-height: $brand.typography.headings.line-height$,
$endif$
$if(heading-fontsize)$
  heading-fontsize: $heading-fontsize$,
$elseif(brand.typography.headings.size)$
  heading-fontsize: $brand.typography.headings.size$,
$endif$

$if(link-family)$
  link-family: ($for(link-family)$"$link-family$",$endfor$),
$elseif(brand.typography.link.family)$
  link-family: $brand.typography.link.family$,
$endif$
$if(linkcolor)$
  linkcolor: "$linkcolor$",
$elseif(link-color)$
  linkcolor: "$link-color$",
$elseif(brand.color.primary)$
  linkcolor: "$brand.color.primary$",
$endif$
$if(citecolor)$
  citecolor: "$citecolor$",
$endif$
$if(filecolor)$
  filecolor: "$filecolor$",
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
$if(header-color)$
  header-color: "$header-color$",
$elseif(header-fontfill)$
  header-color: "$header-fontfill$",
$endif$
$if(header-font)$
  header-font: ($for(header-font)$"$header-font$",$endfor$),
$endif$
$if(header-fontsize)$
  header-fontsize: $header-fontsize$,
$endif$
$if(header-align)$
  header-align: $header-align$,
$endif$
$if(header-ascent)$
  header-ascent: $header-ascent$,
$endif$
$if(footer)$
  footer: [$footer$],
$endif$
$if(footer-color)$
  footer-color: "$footer-color$",
$elseif(footer-fontfill)$
  footer-color: "$footer-fontfill$",
$endif$
$if(footer-font)$
  footer-font: ($for(footer-font)$"$footer-font$",$endfor$),
$endif$
$if(footer-fontsize)$
  footer-fontsize: $footer-fontsize$,
$endif$
$if(footer-align)$
  footer-align: $footer-align$,
$endif$
$if(footer-descent)$
  footer-descent: $footer-descent$,
$endif$

// Term (definition) lists

  terms-tight: $if(terms-tight)$true$else$false$endif$,
$if(terms-indent)$
  terms-indent: $terms-indent$,
$endif$
$if(terms-hanging-indent)$
  terms-hanging-indent: $terms-hanging-indent$,
$endif$
$if(terms-spacing)$
  terms-spacing: $terms-spacing$,
$endif$
$if(terms-separator)$
  terms-separator: [$terms-separator$],
$endif$
$if(term-color)$
  term-color: "$term-color$",
$endif$
$if(term-weight)$
  term-weight: "$term-weight$",
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

$if(blockquote-fontsize)$
  blockquote-fontsize: $blockquote-fontsize$,
$endif$

  doc,
)
