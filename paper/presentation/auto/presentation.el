(TeX-add-style-hook "presentation"
 (lambda ()
    (LaTeX-add-bibliographies
     "background")
    (TeX-run-style-hooks
     "tikz"
     "multimedia"
     "etoolbox"
     "latex2e"
     "beamer10"
     "beamer"
     ""
     "introduction"
     "BrownianMotion"
     "Modeling"
     "Nondimensionalization")))

