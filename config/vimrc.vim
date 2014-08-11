set nocompatible              " be iMproved, required
filetype off                  " required

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'                         " Let Vundle manage Vundle, required

" Color schemes
Plugin 'sahands/vim-colors-solarized'          " Use customized copy of altercation/solarized

" Multi-language programming, version control, diffing, etc.
Plugin 'honza/vim-snippets'                    " Snippets repository
Plugin 'mhinz/vim-signify'                     " Gutter for version control systems
Plugin 'scrooloose/syntastic'                  " Syntax checker for a variety of files, including Python
Plugin 'sirver/ultisnips'                      " Snippets
Plugin 'tomtom/tcomment_vim'                   " Comment lines
Plugin 'tpope/vim-fugitive'                    " Git integration. Maybe for future.
Plugin 'Valloric/YouCompleteMe'                " Autocomplete for all sorts of files

" Tabulation, formatting, etc.
Plugin 'AndrewRadev/splitjoin.vim'             " Split join: gS to split, gJ to join
Plugin 'godlygeek/tabular'                     " Tabularize lines
Plugin 'tommcdo/vim-lion'                      " Similar to Tabular but easier to use: gl and gL
Plugin 'tpope/vim-surround'                    " Surround text with stuff
Plugin 'wellle/targets.vim'                    " More targets such as da, (delete after ,) or din)

" Navigation, targets, copy/pasting, undo, etc.
Plugin 'Lokaltog/vim-easymotion'               " Move around with ease
Plugin 'maxbrunsfeld/vim-yankstack'            " Cycle back and forth in the copy/paste history
Plugin 'sjl/gundo.vim'                         " Explore the undo tree
Plugin 'tmhedberg/matchit'                     " % will jump to matching HTML tag, and others
Plugin 'vim-scripts/camelcasemotion'           " CamelCaseMotion

" File navigation
Plugin 'scrooloose/nerdtree.git'               " File system browsing
Plugin 'wincent/Command-T'                     " Open files with ease

" HTML, CSS, Markdown, reStructuredText, LaTeX
Plugin 'LaTeX-Box-Team/LaTeX-Box'              " Lightweight LaTex plugin
Plugin 'ap/vim-css-color'                      " CSS Colors
Plugin 'greyblake/vim-preview'                 " Preview for rst, html, md, etc.
Plugin 'plasticboy/vim-markdown'               " Markdown support
Plugin 'sahands/vim-rst-headers'               " Format RST file headers
Plugin 'tristen/vim-sparkup'                   " Insert HTML using CSS style selectors

" JavaScript, CoffeeScript, node, etc.
Plugin 'alunny/pegjs-vim'                      " Syntax highlighting for pegjs files
Plugin 'digitaltoad/vim-jade'                  " Support jade files
Plugin 'elzr/vim-json'                         " Better JSON support
Plugin 'heavenshell/vim-jsdoc'                 " jsdoc support (:JsDoc or C-l)
Plugin 'jelera/vim-javascript-syntax'          " JavaScript syntax
Plugin 'kchmck/vim-coffee-script'              " CoffeeScript support
Plugin 'leafgarland/typescript-vim'            " TypeScript support
Plugin 'maksimr/vim-jsbeautify'                " Format JS code
Plugin 'moll/vim-node'                         " For when I start node programming... if ever!
Plugin 'vitaly/vim-syntastic-coffee'           " Syntastic support coffeescript
Plugin 'walm/jshint.vim'                       " Run jshint on js files

" Plugin 'vim-scripts/loremipsum'                " Lorem Ipsum generator.
" Plugin 'sjl/threesome.vim'                     " Merge tool
" Plugin 'majutsushi/tagbar'                     " Source code structure
" Plugin 'marijnh/tern_for_vim'                  " Better autocomplete for JavaScript
" Plugin 'valloric/MatchTagAlways'               " Highlight the HTML tag you are currently in.
" Plugin 'tpope/vim-characterize'                " Enable modern, unicode based characterization
" Plugin 'klen/python-mode.git'                " Python development plugin
" Plugin 'bling/vim-airline'                   " Better status line
" Plugin 'terryma/vim-expand-region'           "
" Plugin 'justinmk/vim-sneak'                  " Alternative to EasyMotion
" Plugin 'altercation/vim-colors-solarized'    " Great color scheme
" Plugin 'lepture/vim-jinja'                   " Jinja2 support
" Plugin 'Rykka/riv.vim'                       " For rst files... Seems a bit buggy right now
" Plugin 'vim-scripts/pep8'                    " Not needed with syntastic
" Plugin 'nvie/vim-flake8'                     " Same as pep8
" Plugin 'flazz/vim-colorschemes'              " Using solarized for now
" Plugin 'airblade/vim-gitgutter'              " Add a column to the left with what's been added, changed, etc.
" Plugin 'vim-scripts/taglist.vim'               " Source code structure browsing

filetype plugin indent on                   " required

" ----------  End of Vundle setup code -------------

" Basic settings
syntax on
set autoindent
set autoread                                         " Update modified files automatically
set bs=2                                             " Backspace behaviour
set expandtab
set foldlevel=99
set foldlevelstart=99
set hlsearch                                         " Highlight search
set iskeyword-=_
set noerrorbells                                     " Disable the bell
set nofoldenable                                     " Disable folding by default
set noswapfile
set number                                           " Enable line numbers
set ruler                                            " Show cursor position in status bar
set shiftwidth=4
set shiftwidth=4
set smarttab
set softtabstop=4
set splitbelow                                       " Create new window below
set splitright                                       " Create new window on the right
set t_vb=
set tabstop=4

" MacVim only options
if has("gui_macvim")
    set macmeta                                      " Enable the option key in MacVim
endif

" Remap some keys
let mapleader=","                                    " Set leader key to comma
nnoremap Q gqq                                       " No ex mode. Should probably map this to something useful
nmap <F3> a<C-R>=strftime("%Y-%m-%d %H:%M")<CR><Esc> " F3 will insert current date and time
imap <F3> <C-R>=strftime("%Y-%m-%d %H:%M")<CR>
map <C-J> <C-W>j<C-W>_                               " CTRL-J to focus on above window and maximize
map <C-k> <C-W>k<C-W>_                               " Etc.
map <C-h> <C-W>h<C-W>_
map <C-l> <C-W>l<C-W>_

" EasyMotion shortcuts
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

" QuickFix navigation
map <C-n> :cn<CR>                                    " Next grep or make entry
map <C-p> :cp<CR>                                    " Previous grep or make entry

" NERDTree shortcut
map <Leader>n :NERDTreeToggle<CR>

" Gundo key
nnoremap <Leader>g :GundoToggle<CR>

" UltiSnips keys
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" Enable spell check for some text documents
autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en_ca
autocmd BufNewFile,BufRead *.tex setlocal spell spelllang=en_ca
autocmd BufNewFile,BufRead *.md setlocal spell spelllang=en_ca
autocmd Filetype rst setlocal spell spelllang=en_ca

if has("gui_running")
    set guifont=Droid\ Sans\ Mono:h11
    colorscheme solarized
    let g:solarized_contrast="high"             " Default value is normal
    set background=dark
    " Set the theme based on time of day
    " if strftime("%H") < 19  && strftime("%H") > 5
    "     set background=light
    " else
    "     set background=dark
    " endif

    set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_        " Display invisible characters
    set list
    autocmd! GUIEnter * set vb t_vb=            " Enable visual bell
    nnoremap <silent> <esc> :noh<cr><esc>       " hitting escape in command mode will clear last search
endif

" For vim-gitgutter, set the column bg color to same as number column
highlight clear SignColumn

" Some commands
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Remove trailing whitespaces from C, CPP, Java, PHP, Ruby, Python, and Coffee files on save
autocmd FileType c,cpp,java,php,ruby,python,coffee autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" And make a command for it too
command! DelTrailingSpace :call <SID>StripTrailingWhitespaces()

" Format scss files
command! ScssFormat silent !sass-convert % % --to=scss

" Replace tabs with four spaces
command! KillTabs :%s/\t/    /g

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

" Consider swig files to be jinja2 files for now
au BufNewFile,BufRead *.swig set filetype=htmldjango

" JsBeautify shortcuts
autocmd FileType javascript noremap <buffer> <c-f> :call JsBeautify()<cr>
autocmd FileType htmldjango noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType swcss, css noremap <buffer> <c-f> :call CSSBeautify()<cr>
" ScssFormat shortcut
autocmd FileType scss noremap <buffer> <c-f> :ScssFormat<cr>

" Disable jsdoc default Ctrl-l mapping
let g:jsdoc_default_mapping=0
