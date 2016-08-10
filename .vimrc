"Set up pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect('bundle/{}')
Helptags

filetype plugin indent on
syntax on
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
set hlsearch
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set relativenumber
set number
set tw=90

set laststatus=2
set statusline+=%f\ 
set statusline+=%=  
set statusline+=%{gutentags#statusline()}
set statusline+=\ %c:%l\ 

highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%91v', 100)
set backspace=2
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

"set t_Co=256
"colorscheme CandyPaper
colorscheme molokai
"set background=dark
"let g:solarized_termcolors=256
"let g:solarized_termtrans=0
"colorscheme solarized
