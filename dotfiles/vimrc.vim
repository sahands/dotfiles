set nocompatible              " be iMproved, required
filetype off                  " required

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'                         " Let Vundle manage Vundle, required
Plugin 'sahands/vim-colors-solarized'          " Use customized copy of altercation/solarized
Plugin 'scrooloose/syntastic.git'              " Syntax checker for a variety of files, including Python
Plugin 'godlygeek/tabular.git'                 " Tabularize lines
Plugin 'tomtom/tcomment_vim.git'               " Comment lines
Plugin 'Lokaltog/vim-easymotion.git'           " Move around with ease
Plugin 'tpope/vim-surround.git'                " Surround text with stuff
Plugin 'wincent/Command-T'                     " Open files with ease
Plugin 'Valloric/YouCompleteMe'                " Autocomplete for all sorts of files
Plugin 'sirver/ultisnips'                      " Snippets
Plugin 'honza/vim-snippets'                    " Snippets repository
Plugin 'tristen/vim-sparkup'                   " Insert HTML using CSS style selectors
Plugin 'maxbrunsfeld/vim-yankstack'            " Cycle back and forth in the copy/paste history
Plugin 'tpope/vim-characterize'                " Enable modern, unicode based characterization
Plugin 'tmhedberg/matchit'                     " % will jump to matching HTML tag, and others
Plugin 'valloric/MatchTagAlways'               " Highlight the HTML tag you are currently in.
Plugin 'sjl/gundo.vim'                         " Explore the undo tree
Plugin 'plasticboy/vim-markdown'               " Markdown support
Plugin 'vim-scripts/taglist.vim'               " Source code structure browsing
Plugin 'mhinz/vim-signify'                     " Gutter for version control systems

" Plugin 'altercation/vim-colors-solarized' " Great color scheme
" Plugin 'lepture/vim-jinja'                " Jinja2 support
" Plugin 'vim-fugitive'                     " Git integration. Maybe for future.
" Plugin 'moll/vim-node.git'                " For when I start node programming... if ever!
" Plugin 'Rykka/riv.vim.git'                " For rst files... Seems a bit buggy right now
" Plugin 'vim-scripts/pep8.git'             " Not needed with syntastic
" Plugin 'nvie/vim-flake8.git'              " Same as pep8
" Plugin 'flazz/vim-colorschemes.git'       " Using solarized for now
" Plugin 'airblade/vim-gitgutter'                " Add a column to the left with what's been added, changed, etc.

filetype plugin indent on                   " required

" ----------  End of Vundle setup code -------------

" Basic settings
syntax on
set tabstop=4
set shiftwidth=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smarttab
set noswapfile
set number                                           " Enable line numbers
set macmeta                                          " Enable the option key in MacVim
set nofoldenable                                     " Disable folding by default
set foldlevelstart=99
set foldlevel=99
set hlsearch                                         " Highlight search
set bs=2                                             " Backspace behaviour
set ruler                                            " Show cursor position in status bar
set iskeyword-=_
set noerrorbells                                     " Disable the bell
set t_vb=

" Remap some keys
let mapleader=","                                    " Set leader key to comma
nnoremap <silent> <esc> :noh<cr><esc>                " hitting escape in command mode will clear last search
nnoremap K i<CR><Esc>                                " Capital K inserts a newline character where you are
nnoremap Q gqq                                       " Die ex mode, die. Should probably map this to something useful
nnoremap <Leader>s :TlistToggle<CR>                  " Open TagList
nmap <F3> a<C-R>=strftime("%Y-%m-%d %H:%M")<CR><Esc> " F3 will insert current date and time
imap <F3> <C-R>=strftime("%Y-%m-%d %H:%M")<CR>

" Enable spell check for some text documents
autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en_ca
autocmd BufNewFile,BufRead *.tex setlocal spell spelllang=en_ca
autocmd BufNewFile,BufRead *.md setlocal spell spelllang=en_ca
autocmd Filetype rst setlocal spell spelllang=en_ca

if has("gui_running")
    set guifont=Droid\ Sans\ Mono:h13
    colorscheme solarized
    let g:solarized_contrast="high"             " Default value is normal
    " Set the theme based on time of day
    if strftime("%H") < 19  && strftime("%H") > 5
        set background=light
    else
        set background=dark
    endif

    set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_        " Display invisible characters
    set list
    autocmd! GUIEnter * set vb t_vb=            " Enable visual bell
endif

" EasyMotion configuration
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

" UltiSnips Settings
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" Some commands
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

" Enable sparkup for other file types
augroup sparkup_types
  " Remove ALL autocommands of the current group.
  autocmd!
  " Add sparkup to new filetypes
  autocmd FileType html,mustache,php,htmldjango runtime! ftplugin/html/sparkup.vim
augroup END

" I hardly ever edit a pure HTML file. Set default jinja
au BufNewFile,BufRead *.html set filetype=htmldjango
