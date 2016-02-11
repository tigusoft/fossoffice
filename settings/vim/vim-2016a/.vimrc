:syntax on

":set autoindent
:set smartindent

:set hlsearch

""" tabs

:set noexpandtab
:set copyindent
":set preserveindent

:set smarttab

" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
:set softtabstop=0

" size of an "indent"
:set shiftwidth=2

" size of a hard tabstop
:set tabstop=2

:inoremap ` <C-n>

:inoremap <F2> <c-o>:w<CR>
:noremap <F2> <Esc>:w<CR>

:inoremap <F9> <C-\><C-O>:w<CR><C-\><C-O>:!clear<CR><C-\><C-O>:make run<CR>
:noremap <F9> :w<CR>:!clear<CR>:make run<CR>

set viminfo='20,\"100000

" Tab navigation like Firefox.
"nnoremap <C-S-tab> :tabprevious<CR>
"nnoremap <C-tab>   :tabnext<CR>
"nnoremap <C-t>     :tabnew<CR>
"inoremap <C-S-tab> <Esc>:tabprevious<CR>i
"inoremap <C-tab>   <Esc>:tabnext<CR>i
"inoremap <C-t>     <Esc>:tabnew<CR>

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window (for an alternative on Windows, see simalt below).
  set lines=999 columns=999
else
  " This is console Vim.
  "if exists("+lines")
  "  set lines=50
  "endif
  "if exists("+columns")
  "  set columns=100
  "endif
endif



