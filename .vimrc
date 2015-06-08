" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set autoread "Reload files changed outside vim

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital


" CTRL+S save
:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>a
