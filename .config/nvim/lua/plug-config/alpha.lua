local alpha = require("alpha")

local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
"     .-\'~~~-.",
"   .\'o  oOOOo`.",
"  :~~~-.oOo   o`.",
"   `. \\ ~-.  oOOo.",
"     `.; / ~.  OO:",
"     .\'  ;-- `.o.\'",
"    ,\'  ; ~~--\'~",
"    ;  ;",
"_\\\\;_\\\\//_____",
}

alpha.setup(dashboard.opts)
