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
Plugin 'davidhalter/jedi-vim.git'
Plugin 'flazz/vim-colorschemes.git'
Plugin 'wincent/Command-T'
Plugin 'Valloric/YouCompleteMe'

" scripts from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Plugin 'FuzzyFinder'

filetype plugin indent on     " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin commands are not allowed.
" Put your stuff after this line


" ----------  end of Vundle setup code -------------

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
:nnoremap K i<CR><Esc>


" hitting escape in command mode will clear last search
nnoremap <silent> <esc> :noh<cr><esc>

" filetype indent on
" filetype on

if has("gui_running")
    set hlsearch
    " colorscheme distinguished
    " colorscheme badwolf
    " colorscheme gruvbox
    colorscheme jellybeans
    " colorscheme busybee
    " colorscheme hybrid
    " colorscheme inkpot
    set bg=dark    " Setting dark mode
    filetype plugin on
    set bs=2
    set ai
    set ruler
    set iskeyword-=_

    " Display invisible characters
    set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
    set list



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

    "autocmd BufWritePre *.py :%s/\s\+$//e 

    " Convert $x$ to :math:`x`
    command! Tex2rst :%s/\$\(.\{-}\)\$/:math:`\1`/ge  | :%s/\$\$\(.\{-}\)\$\$/\r\r.. math::\r\r\t\1\r\r/ge

    " Disable the bell
    set noerrorbells 
    set novisualbell
    set t_vb=

    " F3 will insert current date and time
    nmap <F3> a<C-R>=strftime("%Y-%m-%d %H:%M")<CR><Esc>
    imap <F3> <C-R>=strftime("%Y-%m-%d %H:%M")<CR>

    " Disable folding by default
    set nofoldenable 
    set foldlevelstart=99
    set foldlevel=99

    set guifont=Droid\ Sans\ Mono:h13
    autocmd! GUIEnter * set vb t_vb=

    " Display a ruler at text-width
    " Nevermind: this looks ugly!
    " :set colorcolumn=+1        " highlight column after 'textwidth'
    " :set colorcolumn=+1,+2,+3  " highlight three columns after 'textwidth'
    " :highlight ColorColumn ctermbg=grey guibg=grey
endif


" Indent Python in the Google way.
setlocal indentexpr=GetGooglePythonIndent(v:lnum)
let s:maxoff = 50 " maximum number of lines to look backwards.
function GetGooglePythonIndent(lnum)
  " Indent inside parens.
  " Align with the open paren unless it is at the end of the line.
  " E.g.
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif

  " Delegate the rest to the original function.
  return GetPythonIndent(a:lnum)

endfunction

let pyindent_nested_paren="&sw*2"
let pyindent_open_paren="&sw*2"
