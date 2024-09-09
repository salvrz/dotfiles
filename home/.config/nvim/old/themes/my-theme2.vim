" Vim color file
" black
" Created by  with ThemeCreator (https://github.com/mswift42/themecreator)

hi clear

if exists("syntax on")
syntax reset
endif

set t_Co=256
let g:colors_name = "my-theme2"

" Define reusable colorvariables.
let s:bg="#131A1C"
let s:fg="#ffffff"
let s:fg2="#ebebeb"
let s:fg3="#d6d6d6"
let s:fg4="#c2c2c2"
let s:bg2="#262c2e"
let s:bg3="#393f40"
let s:bg4="#4c5152"
let s:keyword="#00CDC1"
let s:builtin="#76AAB6"
let s:const= "#EF9B00"
let s:comment="#4A8089"
let s:func="#76AAB6"
let s:str="#5D705C"
let s:type="#FF006F"
let s:var="#90837A"
let s:warning="#D3441C"
let s:warning2="#FF006F"

hi Normal guifg=s:fg guibg=s:bg
hi Cursor guifg=s:bg guibg=s:fg
hi CursorLine  guibg=s:bg2
hi CursorLineNr guifg=s:str guibg=s:bg
hi CursorColumn  guibg=s:bg2
hi ColorColumn  guibg=s:bg2
hi LineNr guifg=s:fg2 guibg=s:bg2
hi VertSplit guifg=s:fg3 guibg=s:bg3
hi MatchParen guifg=s:warning2  gui=underline
hi StatusLine guifg=s:fg2 guibg=s:bg3 gui=bold
hi Pmenu guifg=s:fg guibg=s:bg2
hi PmenuSel  guibg=s:bg3
hi IncSearch guifg=s:bg guibg=s:keyword
hi Search   gui=underline
hi Directory guifg=s:const
hi Folded guifg=s:fg4 guibg=s:bg
hi WildMenu guifg=s:str guibg=s:bg

hi Boolean guifg=s:const
hi Character guifg=s:const
hi Comment guifg=s:comment
hi Conditional guifg=s:keyword
hi Constant guifg=s:const
hi Todo guibg=s:bg
hi Define guifg=s:keyword
hi DiffAdd guifg=#fafafa guibg=#123d0f gui=bold
hi DiffDelete guibg=s:bg2
hi DiffChange  guibg=#151b3c guifg=#fafafa
hi DiffText guifg=#ffffff guibg=#ff0000 gui=bold
hi ErrorMsg guifg=s:warning guibg=s:bg2 gui=bold
hi WarningMsg guifg=s:fg guibg=s:warning2
hi Float guifg=s:const
hi Function guifg=s:func
hi Identifier guifg=s:type  gui=italic
hi Keyword guifg=s:keyword  gui=bold
hi Label guifg=s:var
hi NonText guifg=s:bg4 guibg=s:bg2
hi Number guifg=s:const
hi Operator guifg=s:keyword
hi PreProc guifg=s:keyword
hi Special guifg=s:fg
hi SpecialKey guifg=s:fg2 guibg=s:bg2
hi Statement guifg=s:keyword
hi StorageClass guifg=s:type  gui=italic
hi String guifg=s:str
hi Tag guifg=s:keyword
hi Title guifg=s:fg  gui=bold
hi Todo guifg=s:fg2  gui=inverse,bold
hi Type guifg=s:type
hi Underlined   gui=underline

" Neovim Terminal Mode
let g:terminal_color_0 = s:bg
let g:terminal_color_1 = s:warning
let g:terminal_color_2 = s:keyword
let g:terminal_color_3 = s:bg4
let g:terminal_color_4 = s:func
let g:terminal_color_5 = s:builtin
let g:terminal_color_6 = s:fg3
let g:terminal_color_7 = s:str
let g:terminal_color_8 = s:bg2
let g:terminal_color_9 = s:warning2
let g:terminal_color_10 = s:fg2
let g:terminal_color_11 = s:var
let g:terminal_color_12 = s:type
let g:terminal_color_13 = s:const
let g:terminal_color_14 = s:fg4
let g:terminal_color_15 = s:comment

" Ruby Highlighting
hi rubyAttribute guifg=s:builtin
hi rubyLocalVariableOrMethod guifg=s:var
hi rubyGlobalVariable guifg=s:var gui=italic
hi rubyInstanceVariable guifg=s:var
hi rubyKeyword guifg=s:keyword
hi rubyKeywordAsMethod guifg=s:keyword gui=bold
hi rubyClassDeclaration guifg=s:keyword gui=bold
hi rubyClass guifg=s:keyword gui=bold
hi rubyNumber guifg=s:const

" Python Highlighting
hi pythonBuiltinFunc guifg=s:builtin

" Go Highlighting
hi goBuiltins guifg=s:builtin
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints      = 1
let g:go_highlight_chan_whitespace_error  = 1
let g:go_highlight_extra_types            = 1
let g:go_highlight_fields                 = 1
let g:go_highlight_format_strings         = 1
let g:go_highlight_function_calls         = 1
let g:go_highlight_function_parameters    = 1
let g:go_highlight_functions              = 1
let g:go_highlight_generate_tags          = 1
let g:go_highlight_operators              = 1
let g:go_highlight_space_tab_error        = 1
let g:go_highlight_string_spellcheck      = 1
let g:go_highlight_types                  = 1
let g:go_highlight_variable_assignments   = 1
let g:go_highlight_variable_declarations  = 1

" Javascript Highlighting
hi jsBuiltins guifg=s:builtin
hi jsFunction guifg=s:keyword gui=bold
hi jsGlobalObjects guifg=s:type
hi jsAssignmentExps guifg=s:var

" Html Highlighting
hi htmlLink guifg=s:var gui=underline
hi htmlStatement guifg=s:keyword
hi htmlSpecialTagName guifg=s:keyword

" Markdown Highlighting
hi mkdCode guifg=s:builtin


