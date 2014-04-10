execute pathogen#infect()
syntax on

set tabstop=4
set shiftwidth=4
set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent
set smarttab
set noswapfile

filetype indent on
filetype on

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

    :nnoremap K i<CR><Esc>

    " hitting escape in command mode will clear last search
    nnoremap <silent> <esc> :noh<cr><esc>

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
