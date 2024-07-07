
-- Assumed to be one-character-long
smart_abbrev_delim = "\\"

smart_abbrev_map = {
  -- Greek letters
  {"Delta"  , "Δ"},
  {"Gamma"  , "Γ"},
  {"Omega"  , "Ω"},
  {"Pi"     , "Π"},
  {"Sigma"  , "Σ"},
  {"Theta"  , "ϴ"},
  {"theta"  , "θ"},
  {"alpha"  , "α"},
  {"beta"   , "β"},
  {"delta"  , "δ"},
  {"epsilon", "ε"},
  {"eps"    , "ε"},
  {"eps-"   , "ε̄"},
  {"eta"    , "η"},
  {"gamma"  , "γ"},
  {"lambda" , "λ"},
  {"Lambda" , "Λ"},
  {"\\"     , "λ"},
  {"mu"     , "μ"},
  {"nu"     , "𝜈"},
  {"omega"  , "ω"},
  {"pi"     , "π"},
  {"sigma"  , "σ"},
  {"tau"    , "τ"},
  {"psi"    , "ψ"},
  {"rho"    , "ρ"},
  {"xi"     , "ξ"},
  {"Xi"     , "Ξ"},
  {"kappa"  , "κ"},
  {"iota"   , "ι"},
  {"zeta"   , "ζ"},
  {"Phi"    , "Φ"},
  {"phi"    , "φ"},
  {"Psi"    , "Ψ"},
  {"psi"    , "𝜓"},
  {"chi"    , "χ"},

  -- Italic
  {"y"      , "𝑦"},

  -- Double struck symbols
  {"Zero" , "𝟘"},
  {"One"  , "𝟙"},
  {"C"    , "ℂ"},
  {"D"    , "𝔻"},
  {"U"    , "𝕌"},
  {"Two"  , "𝟚"},
  {"Three", "𝟛"},
  {"Four" , "𝟜"},
  {"Five" , "𝟝"},
  {"Six"  , "𝟞"},
  {"Seven", "𝟟"},
  {"Eight", "𝟠"},
  {"Nine" , "𝟡"},
  {"A"    , "𝔸"},
  {"B"    , "𝔹"},
  {"C"    , "ℂ"},
  {"I"    , "𝕀"},
  {"N"    , "ℕ"},
  {"R"    , "ℝ"},
  {"Q"    , "ℚ"},
  {"Z"    , "ℤ"},
  {"E"    , "𝔼"},
  {"T"    , "𝕋"},
  {"P"    , "ℙ"},
  {"S"    , "𝕊"},
  {"F"    , "𝔽"},
  {"J"    , "𝕁"},

  -- Bold symbols
  {"bI"   , "𝐈"},

  -- Math script
  {"mK"   , "𝒦"},
  {"ml"   , "ℓ"},
  {"mL"   , "ℒ"},
  {"mC"   , "𝒞"},
  {"ma"   , "𝒶"},
  {"mM"   , "𝓜"},
  {"mN"   , "𝒩"},
  {"mA"   , "𝒜"},
  {"mP"   , "𝒫"},
  {"mB"   , "𝓑"},
  {"mX"   , "𝒳"},
  {"mx"   , "𝓍"},
  -- mathematical bold small epsilon
  {"meps" , "𝛆"},

  -- Numbers
  {"0", "𝟢"},
  {"1", "𝟣"},

  -- Subscripts
  {"sub0"   , "₀"},
  {"sub1"   , "₁"},
  {"sub01"  , "₀₁"},
  {"sub12"  , "₁₂"},
  {"^-1"    , "⁻¹"},
  {"sub2"   , "₂"},
  {"sub3"   , "₃"},
  {"sub4"   , "₄"},
  {"sub5"   , "₅"},
  {"sub6"   , "₆"},
  {"sub7"   , "₇"},
  {"sub8"   , "₈"},
  {"sub9"   , "₉"},
  {"subi"   , "ᵢ"},
  {"subj"   , "ⱼ"},
  {"subx"   , "ₓ"},
  {"_0"   , "₀"},
  {"_1"   , "₁"},
  {"_01"  , "₀₁"},
  {"_12"  , "₁₂"},
  {"_2"   , "₂"},
  {"_3"   , "₃"},
  {"_4"   , "₄"},
  {"_5"   , "₅"},
  {"_6"   , "₆"},
  {"_7"   , "₇"},
  {"_8"   , "₈"},
  {"_9"   , "₉"},
  {"_i"   , "ᵢ"},
  {"_x"   , "ₓ"},
  {"pi1"    , "π₁"},
  {"pi2"    , "π₂"},
  {"i0"     , "i₀"},
  {"i1"     , "i₁"},
  {"I0"     , "𝕀₀"},
  {"I1"     , "𝕀₁"},
  {"sub+"   , "₊"},
  {"sub-"   , "₋"},
  {"_+"   , "₊"},
  {"_-"   , "₋"},
  {"_<"   , "˱"},
  {"_>"   , "˲"},
  {"_l"   , "ₗ"},
  {"_r"   , "ᵣ"},
  {"_u"   , "ᵤ"},
  {"_n"   , "ₙ"},
  {"_m"   , "ₘ"},
  {"_p"   , "ₚ"},
  {"_a"   , "ₐ"},
  {"_k"   , "ₖ"},
  {"_s"   , "ₛ"},
  {"_j"   , "ⱼ"},

  -- Superscripts
  {"sup=" , "⁼"},
  {"^="   , "⁼"},
  {"sup+" , "⁺"},
  {"sup-" , "⁻"},
  {"^-1"    , "⁻¹"},
  {"^+" , "⁺"},
  {"^-" , "⁻"},
  {"sup0" , "⁰"},
  {"sup1" , "¹"},
  {"sup2" , "²"},
  {"sup3" , "³"},
  {"sup4" , "⁴"},
  {"sup5" , "⁵"},
  {"sup6" , "⁶"},
  {"sup7" , "⁷"},
  {"sup8" , "⁸"},
  {"sup9" , "⁹"},
  {"^0" , "⁰"},
  {"^1" , "¹"},
  {"^2" , "²"},
  {"^3" , "³"},
  {"^4" , "⁴"},
  {"^5" , "⁵"},
  {"^6" , "⁶"},
  {"^7" , "⁷"},
  {"^8" , "⁸"},
  {"^9" , "⁹"},
  {"^i" , "ⁱ"},
  {"^n" , "ⁿ"},
  {"^x" , "ˣ"},
  {"^c" , "ᶜ"},
  {"^p" , "ᵖ"},
  {"^m" , "ᵐ"},
  {"^k" , "ᵏ"},
  {"^~" , "˜"},
  {"^~" , "˜"},
  {"^L" , "ᴸ"},
  {"^R" , "ᴿ"},

  -- Math
  {"sqrt"         , "√"},
  {":="           , "≔"},
  {"exists"       , "∃"},
  {"nexists"      , "∄"},
  {"forall"       , "∀"},
  {"iff"          , "⇔"},
  {"implies"      , "⇒"},
  {"neg"          , "¬"},
  {"and"          , "∧"},
  {"or"           , "∨"},
  {"elem"         , "∈"},
  {"relem"        , "∋"},
  {"iso"          , "≅"},
  {"niso"         , "≇"},
  {"equiv"        , "≃"},
  {"neq"          , "≠"},
  {"id"           , "≡"},
  {"nid"          , "≢"},
  {"def"          , "≜"},
  {"propersubset" , "⊂"},
  {"inclusion"    , "⊂"},
  {"notincluded"  , "⊄"},
  {"crossprod"    , "⨯"},
  {"cp"           , "⨯"},
  {"stprod"       , "☓"},
  {"inf"          , "∞"},
  {"gte"          , "≥"},
  {"gte'"         , "≽"},
  {"lte"          , "≤"},
  {"nlt"          , "≮"},
  {"lte'"         , "≼"},
  {"notelem"      , "∉"},
  {"empty"        , "∅"},
  {"subset"       , "⊆"},
  {"<-"           , "←"},
  {"maplet"       , "↦"},
  {"map"          , "↦"},
  {"<->"          , "⟷"},
  {"swap"         , "⟷"},
  {"bottom"       , "⊥"},
  {"top"          , "⊤"},
  {"union"        , "∪"},
  {"disjointunion", "⊔"},
  {"dunion"       , "⊔"},
  {"du"           , "⊔"},
  {"dp"           , "⊓"},
  {"intersect"    , "∩"},
  {"ring"         , "∘"},
  {"tensorsum"    , "⊕"},
  {"tensorprod"   , "⊗"},
  {"symdiff"      , "⊖"},
  {"->"           , "→"},
  {"->>"          , "↠"},
  {">->>"         , "⤐"},
  {"<="           , "⇐"},
  {"=>"           , "⇒"},
  {"≡>"           , "⇛"},
  {"<≡"           , "⇚"},
  {"<=>"          , "⇔"},
  {"qed"          , "∎"},
  {"+-"           , "±"},
  {"lol"          , "⊸"},
  {"dotprod"      , "·"},
  {"dt"           , "·"},
  {"dot"          , "∙"},
  {"ltack"        , "⊣"},
  {"turn"         , "⊦"},
  {"|-"           , "⊦"},
  {"dturn"        , "⊧"},
  {"ndturn"       , "⊯"},
  {"~>"           , "⇝"},
  {"-|>>"         , "⇾"},
  {"|>"           , "ᐅ"},
  {"!"            , "¡"},
  {"|=>"          , "⤇"},
  {"inj"          , "↪"},
  {"~~"           , "≈"},
  {"not~~"        , "≉"},
  {"downright"    , "↳"},
  {"downleft"     , "↲"},
  {"::"           , "∷"},
  {"pdif"         , "∂"},
  {"quot"         , "÷"},

  -- Brackets and bars
  {"leftangle" , "⟨"},
  {"<"         , "⟨"},
  {"rightangle", "⟩"},
  {">"         , "⟩"},
  {"<<"        , "⟪"},
  {">>"        , "⟫"},
  {"["         , "⟦"},
  {"]"         , "⟧"},
  {"("         , "⸨"},
  {")"         , "⸩"},
  {"|"         , "‖"},
  {"(|"        , "⦇"},
  {"|)"        , "⦈"},
  {"{|"        , "⦃"},
  {"|}"        , "⦄"},
  {"{("        , "⧼"},
  {")}"        , "⧽"},

  -- Miscelaneous
  {"up"            , "↑"},
  {"down"          , "↓"},
  {"!down"         , "⇣"},
  {"left"          , "←"},
  {"right"         , "→"},
  {"pright"        , "⇀"},
  {"dright"        , "⇉"},
  {"downright"     , "↳"},
  {"tick"          , "✔"},
  {"cross"         , "✗"},
  {"prime"         , "′"},
  {"`"             , "‘"},
  {"'"             , "‛"},
  {"ntilde"        , "≁"},
  {"--"            , "—"},
  {"space"         , "␣"},
  {"="             , "═"},
  {">>"            , "≫"},
  {"twin"          , "‡"},
  {"=|="           , "‡"},
  {"box"           , "☐"},
  {"triangle"      , "△"},
  {"diamond"       , "◇"},
  {"lock"          , ""},
  {"unlock"        , ""},

  -- Combining marks
  {"acac"          , "́"},
  {"macron"        , "̄"},
  {"cmbdot"        , "̇"},
  {"^_"            , "̅"},
  {"_"             , "̲"},
  {"under"         , "̲"},
  {"^^"            , "̂"},

  -- Borders
  {"|_"            , "⌊"},
  {"_|"            , "⌋"},
  {"|^_"           , "⌈"},
  {"^_|"           , "⌉"}
}
