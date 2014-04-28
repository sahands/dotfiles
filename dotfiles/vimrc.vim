set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'

" scripts on GitHub repos

" For when I start node programming... if ever!
" Plugin 'moll/vim-node.git'

" For rst files... Seems a bit buggy right now
" Plugin 'Rykka/riv.vim.git'

" These are not needed with syntastic
" Plugin 'vim-scripts/pep8.git'
" Plugin 'nvie/vim-flake8.git'

" Using solarized for now
" Plugin 'flazz/vim-colorschemes.git'

" Great color scheme
Plugin 'altercation/vim-colors-solarized'
" Syntax checker for a variety of files, including Python
Plugin 'scrooloose/syntastic.git'
" Tabularize lines
Plugin 'godlygeek/tabular.git'
" Comment lines
Plugin 'tomtom/tcomment_vim.git'
" Move around with ease
Plugin 'Lokaltog/vim-easymotion.git'
" Surround text with stuff
Plugin 'tpope/vim-surround.git'
" Open files with ease
Plugin 'wincent/Command-T'
" Autocomplete for all sorts of files
Plugin 'Valloric/YouCompleteMe'
" Snippets
Plugin 'sirver/ultisnips'
" Snippets repository
Plugin 'honza/vim-snippets'
" Insert HTML using CSS style selectors
Plugin 'rstacruz/sparkup'
" Cycle back and forth in the copy/paste history
Plugin 'maxbrunsfeld/vim-yankstack'
" Add a column to the left with what's been added, changed, etc.
Plugin 'airblade/vim-gitgutter'
" Enable modern, unicode based characterization
Plugin 'tpope/vim-characterize'
" % will jump to matching HTML tag, and others
Plugin 'tmhedberg/matchit'
" Highlight the HTML tag you are currently in.
Plugin 'valloric/MatchTagAlways'
" Explore the undo tree
Plugin 'sjl/gundo.vim'

" Maybe for future
Plugin 'vim-fugitive'


" scripts from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Plugin 'FuzzyFinder'

filetype plugin indent on     " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
" ----------  end of Vundle setup code -------------

" ----------  ultisnips config --------------------
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" --------------  end of ultisnips config --------------

syntax on

set tabstop=4
set shiftwidth=4
set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent
set smarttab
set noswapfile
set number  " Enable line numbers
set macmeta " Enable the option key in MacVim

" Capital K inserts a newline character where you are
:nnoremap K i<CR><Esc>

" Die ex mode, die. Should probably map this to something useful
nnoremap Q gqq

" Latex options
autocmd Filetype tex set textwidth=80

" Remap flake8 key
autocmd FileType python map <buffer> <F6> :call Flake8()<CR>

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Remove trailing whitespaces from C, CPP, Java, PHP, Ruby and Python files on save
autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
" And make a command for it too
command! DelTrailingSpace :call <SID>StripTrailingWhitespaces()

" Convert $x$ to :math:`x`
command! Tex2rst :%s/\$\(.\{-}\)\$/:math:`\1`/ge  | :%s/\$\$\(.\{-}\)\$\$/\r\r.. math::\r\r\t\1\r\r/ge

"
" " F3 will insert current date and time
" nmap <F3> a<C-R>=strftime("%Y-%m-%d %H:%M")<CR><Esc>
" imap <F3> <C-R>=strftime("%Y-%m-%d %H:%M")<CR>
"
" Disable folding by default
set nofoldenable
set foldlevelstart=99
set foldlevel=99

" Enable spell check for some text documents
autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en_ca
autocmd BufNewFile,BufRead *.tex setlocal spell spelllang=en_ca
autocmd BufNewFile,BufRead *.md setlocal spell spelllang=en_ca
autocmd Filetype rst setlocal spell spelllang=en_ca

if has("gui_running")
    " colorscheme distinguished
    " colorscheme badwolf
    " colorscheme gruvbox
    " colorscheme jellybeans
    " colorscheme busybee
    " colorscheme inkpot
    " colorscheme hybrid

    colorscheme solarized
    " Set the theme based on time of day
    if strftime("%H") < 19  && strftime("%H") > 5
        set background=light
    else
        set background=dark
    endif

    " Highlight search
    set hlsearch
    set bs=2
    set ai
    set ruler
    set iskeyword-=_

    " hitting escape in command mode will clear last search
    nnoremap <silent> <esc> :noh<cr><esc>

    " Display invisible characters
    set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
    set list

    set guifont=Droid\ Sans\ Mono:h13

    autocmd! GUIEnter * set vb t_vb=
endif

" Disable the bell
set noerrorbells
set t_vb=

" Set leader key to comma
let mapleader=","

" Some easy motion configuration
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)


" MatchItAlways filetypes
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'htmldjango' : 1,
    \}

" For vim-gitgutter, set the column bg color to same as number column
highlight clear SignColumn

" Gundo key
nnoremap <Leader>g :GundoToggle<CR>
