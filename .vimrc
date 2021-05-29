filetype indent on
filetype plugin on
syntax on
set pastetoggle=<F2>
colorscheme elflord
set nowrap
set tabstop=4
set backspace=indent,eol,start
set autoindent
set copyindent
set shiftwidth=4
set shiftround
set showmatch
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch
set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class
set title
set visualbell
set noerrorbells
set hidden
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
autocmd filetype html,xml set listchars-=tab:>.
nnoremap ,/ :nohlsearch<Bar>:echo<CR>
nnoremap ; :
set mouse=
set t_BE=
inoremap <F2> <ESC>:set paste!<CR>i
nnoremap <F2> :set paste!<CR>
