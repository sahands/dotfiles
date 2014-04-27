set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'

" scripts on GitHub repos
Plugin 'moll/vim-node.git'
Plugin 'vim-scripts/pep8.git'
Plugin 'Rykka/riv.vim.git'
Plugin 'godlygeek/tabular.git'
Plugin 'tomtom/tcomment_vim.git'
Plugin 'Lokaltog/vim-easymotion.git'
Plugin 'nvie/vim-flake8.git'
Plugin 'tpope/vim-surround.git'
Plugin 'scrooloose/syntastic.git'
Plugin 'flazz/vim-colorschemes.git'
Plugin 'wincent/Command-T'
Plugin 'Valloric/YouCompleteMe'
Plugin 'sirver/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'altercation/vim-colors-solarized'

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
set number

" Capital K inserts a newline character where you are
:nnoremap K i<CR><Esc>


" Latex options
autocmd Filetype tex set textwidth=80
autocmd Filetype tex setlocal spell spelllang=en_ca

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
autocmd FileType rst,txt,md :setlocal spell

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
