set nocompatible              " be iMproved, required

" ----------  Start of Plug setup code -------------

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

" File navigation plugins
" Plug 'wincent/Command-T'                     " Open files with ease
" Plug 'kien/ctrlp.vim'                        " Open files, buffers, tags, etc with ease
" Plug 'scrooloose/nerdtree'                   " File system browsing

" Undo/Redo and Copy/Paste plugins
Plug 'sjl/gundo.vim'                         " Explore the undo tree
Plug 'maxbrunsfeld/vim-yankstack'            " Cycle back and forth in the copy/paste history

" Multi-purpose and programming related plugins
Plug 'scrooloose/syntastic'                  " Syntax checker for a variety of files, including Python
Plug 'tomtom/tcomment_vim'                   " Comment lines
Plug 'mhinz/vim-signify'                     " Gutter for version control systems
Plug 'rking/ag.vim'                          " Fast 'grep -r' replacement (command 'Ag')
" Plug 'airblade/vim-gitgutter'                " Add a column to the left with what's been added, changed, etc.
" Plug 'tpope/vim-fugitive'                    " Git integration
Plug 'Valloric/YouCompleteMe'                " Autocomplete for all sorts of files

" JavaScript/CoffeeScript/Etc. specific
" Plug 'walm/jshint.vim'                       " Run jshint on js files
" Plug 'alunny/pegjs-vim'                      " Syntax highlighting for pegjs files
" Plug 'kchmck/vim-coffee-script'              " CoffeeScript support
" Plug 'digitaltoad/vim-jade'                  " Support jade files
" Plug 'jelera/vim-javascript-syntax'          " JavaScript syntax
Plug 'maksimr/vim-jsbeautify'                " Format JS code
" Plug 'heavenshell/vim-jsdoc'                 " jsdoc support (:JsDoc or C-l)
" Plug 'elzr/vim-json'                         " Better JSON support
" Plug 'moll/vim-node'                         " Node.js support
" Plug 'vitaly/vim-syntastic-coffee'           " Syntastic support coffeescript

" LaTeX/MarkDown/Rst specific
" Plug 'LaTeX-Box-Team/LaTeX-Box'              " Lightweight LaTex plugin
Plug 'plasticboy/vim-markdown'               " Markdown support
Plug 'sahands/vim-rst-headers'               " Format RST file headers
" Plug 'greyblake/vim-preview'                 " Preview for rst, html, md, etc.

" HTML/CSS/Jinja/Etc. Related
Plug 'ap/vim-css-color'                      " CSS Colors
Plug 'mattn/emmet-vim'                       " Quickly edit HTML by typing tags (e.g. 'div>ul>li*3' and typing '<c-y>,')
Plug 'tmhedberg/matchit'                     " % will jump to matching HTML tag, and others
"
" Movement and selection plugins
Plug 'wellle/targets.vim'                    " More targets such as da, (delete after ,) or din)
Plug 'Lokaltog/vim-easymotion'               " Move around with ease
" Plug 'vim-scripts/loremipsum'                " Lorem Ipsum generator.
" Plug 'vim-scripts/camelcasemotion'           " CamelCaseMotion

" Text modification plugins
Plug 'AndrewRadev/splitjoin.vim'             " Split join: gS to split, gJ to join
" Plug 'godlygeek/tabular'                     " Tabularize lines
Plug 'tommcdo/vim-lion'                      " Similar to Tabular but easier to use: gl and gL
Plug 'tpope/vim-surround'                    " Surround text with stuff

" Color schemes
" Plug 'sahands/vim-colors-solarized'          " Use customized copy of altercation/solarized

" Plugins for possible future use
" Plug 'tpope/vim-characterize'              " Enable modern, unicode based characterization
" Plug 'leafgarland/typescript-vim'          " TypeScript support
" Plug 'sjl/threesome.vim'                   " Merge tool
" Plug 'majutsushi/tagbar'                   " Source code structure
" Plug 'valloric/MatchTagAlways'             " Highlight the HTML tag you are currently in.
" Plug 'vim-scripts/pep8'                    " Not needed with syntastic
" Plug 'klen/python-mode.git'                " Python development plugin
" Plug 'Rykka/riv.vim'                       " For rst files... Seems a bit buggy right now
" Plug 'vim-scripts/taglist.vim'             " Source code structure browsing
" Plug 'marijnh/tern_for_vim'                " Better autocomplete for JavaScript
" Plug 'bling/vim-airline'                   " Better status line
" Plug 'altercation/vim-colors-solarized'    " Great color scheme
" Plug 'flazz/vim-colorschemes'              " Using solarized for now
" Plug 'terryma/vim-expand-region'           "
Plug 'nvie/vim-flake8'                     " Same as pep8
" Plug 'lepture/vim-jinja'                   " Jinja2 support
" Plug 'justinmk/vim-sneak'                  " Alternative to EasyMotion
" Plug 'sirver/ultisnips'                    " Snippets
" Plug 'honza/vim-snippets'                  " Snippets repository

" Initialize plugin system
call plug#end()
" ----------  End of Plug setup code -------------

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
set relativenumber

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
" autocmd BufNewFile,BufRead *.tex setlocal spell spelllang=en_ca
autocmd BufNewFile,BufRead *.md setlocal spell spelllang=en_ca
autocmd Filetype rst setlocal spell spelllang=en_ca

if has("gui_running")
    set guifont=Droid\ Sans\ Mono:h13
    colorscheme hybrid

    " set background=dark
    " colorscheme solarized
    " let g:solarized_contrast="high"             " Default value is normal
    " set background=dark
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
fun! ScssFormat()
    :w
    :silent !sass-convert % % --to=scss
    :e %
endfun

" Copy the header and replace with #
" TODO: Figure out a way to do with without 3 commands!
command! MdHeader1 :t.|s/./#/g
command! MdHeader2 :t.|s/./=/g
command! MdHeader3 :t.|s/./-/g

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
" Not anymore... commenting this out
" au BufNewFile,BufRead *.html set filetype=htmldjango

" Consider swig files to be jinja2 files for now
au BufNewFile,BufRead *.swig set filetype=htmldjango

" JsBeautify shortcuts
autocmd FileType javascript noremap <buffer> <c-f> :call JsBeautify()<cr>
autocmd FileType htmldjango noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType swcss, css noremap <buffer> <c-f> :call CSSBeautify()<cr>

" ScssFormat shortcut
autocmd FileType scss noremap <buffer> <c-f> :call ScssFormat()<cr>

" Disable jsdoc default Ctrl-l mapping
let g:jsdoc_default_mapping=0

" Fix the "User defined pattern..." issue
let g:clang_user_options='|| exit 0'

" Disable markdownfolding
let g:vim_markdown_folding_disabled=1


" Disable mccabe for now.
" let g:pymode_lint_checkers=['pyflakes', 'pep8', 'mccabe']
let g:pymode_lint_checkers=['pyflakes', 'pep8']

" Ctrl P settings
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_cmd = 'CtrlP'
