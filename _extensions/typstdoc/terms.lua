-- terms.lua
-- Wrap each definition list in a `typstdoc-terms` call, which rebuilds the
-- items into an explicit Typst `terms()` list so the typstdoc terms options
-- apply and the PDF keeps its list tags (see typst-template.typ).

function DefinitionList(el)
  if not quarto.doc.is_format("typst") then
    return nil
  end

  return {
    pandoc.RawBlock("typst", "#typstdoc-terms["),
    el,
    pandoc.RawBlock("typst", "]"),
  }
end
