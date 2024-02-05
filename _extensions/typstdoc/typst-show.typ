#show: typstdoc.with(

// Document attributes
$if(title)$
  title: "$title$",
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
$if(date)$
  date: $date$,
$endif$
$if(lang)$
  lang: "$lang$",
$endif$
$if(region)$
  region: "$region$",
$endif$
$if(abstract)$
  abstract: [$abstract$],
$endif$

// Page layout, fill, and numbering

$if(papersize)$
  paper: "$papersize$",
$endif$
$if(margin)$
  margin: ($for(margin/pairs)$$margin.key$: $margin.value$,$endfor$),
$endif$
$if(flipped)$
  flipped: $flipped$,
$endif$
cols: $if(columns)$$columns$$else$1$endif$, // Columns
$if(gutter)$
  gutter: $gutter$,
$endif$
$if(fill)$
  fill: $fill$,
$endif$
$if(page-numbering)$
  page-numbering: "$page-numbering$",
$endif$
$if(page-number-align)$
  page-number-align: $page-number-align$,
$endif$

// Typography

$if(mainfont)$
  font: ("$mainfont$"),
$endif$
$if(monofont)$
  monofont: ("$monofont$"),
$endif$
$if(fontsize)$
  fontsize: $fontsize$,
$endif$
$if(fontweight)$
  fontweight: $fontweight$,
$endif$
$if(fontfill)$
  fontfill: $fontfill$,
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
  title-font: ("$title-font$"),
$else$
  title-font: ("$mainfont$"),
$endif$
$if(title-align)$
  title-align: $title-align$,
$endif$
$if(title-size)$
  title-size: $title-size$,
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

// Table of contents

$if(toc)$
  toc: $toc$,
$endif$
$if(toc-title)$
  toc_title: [$toc-title$],
$endif$
  toc_depth: $toc-depth$,

// Header and footer

$if(header)$
  header: [$header$],
$endif$
$if(header-ascent)$
  header-ascent: $header-ascent$,
$endif$
$if(footer)$
  footer: [$footer$],
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

$if(bibliography)$
  bibliography-file: "$bibliography$",
$endif$


)
