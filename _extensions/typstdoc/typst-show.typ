#show: doc => document(
$if(title)$
  title: [$title$],
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
$if(mainfont)$
  font: ("$mainfont$"),
$endif$
$if(fontsize)$
  fontsize: $fontsize$,
$endif$
$if(fontfill)$
  fontfill: $fontfill$,
$endif$
$if(fontweight)$
  fontweight: $fontweight$,
$endif$
$if(justify)$
  justify: $justify$,
$endif$
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
$if(fill)$
  fill: $fill$,
$endif$
$if(section-numbering)$
  sectionnumbering: "$section-numbering$",
$endif$
$if(numbering)$
  numbering: "$numbering$",
$endif$
$if(number-align)$
  number-align: $number-align$,
$endif$
$if(toc)$
  toc: $toc$,
$endif$
$if(toc-title)$
  toc_title: [$toc-title$],
$endif$
  toc_depth: $toc-depth$,
$if(footer)$
  footer: [$footer$],
  footer-descent: [footer-descent],
$endif$
$if(header)$
  header: [$header$],
  header-ascent: [$header-ascent$],
$endif$
  cols: $if(columns)$$columns$$else$1$endif$,
  doc,
)
