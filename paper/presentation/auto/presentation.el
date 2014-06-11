(TeX-add-style-hook "presentation"
 (lambda ()
    (TeX-run-style-hooks
     "tikz"
     "etoolbox"
     "latex2e"
     "beamer10"
     "beamer"
     ""
     "introduction"
     "stochasticDEs")))

