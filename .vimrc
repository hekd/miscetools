" Modeline and Notes {
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
"	This is the personal .vimrc file of keding he.
" }

" Function {
    fun! MySys()
        return "windows"
    endfun

    fun! CreateCscopeTag()
        if (executable('cscope')&&has("cscope"))
            if (MySys() == "windows")
                silent! execute "!dir /b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
            else
                silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"
            endif
            silent! execute "!cscope -Rbkq"
            if filereadable("cscope.out")
                execute "cs add cscope.out"
            endif
        endif
    endf
    
    function! CurDir()
        let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
        return curdir
    endfunction

    function! HasPaste()
        if &paste
            return 'PASTE MODE  '
        else
            return ''
        endif
    endfunction
" }

" Key binding {
    map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>    
    nmap <C-F11> :call CreateCscopeTag()<CR>
    nmap <F8> :NERDTreeToggle<CR>
    map <silent> <F9> :TlistToggle<CR>
" }

set cscopequickfix=s-,c-,d-,i-,t-,e-,g-
let Tlist_Use_Right_Window=1
let NERDTreeWinPos='left'

" General {
    set nocp
    set history=700
    
    filetype plugin on
    filetype indent on
    
    set autoread
    
    let mapleader=","
    let g:mapleader=","
    
    " Fast saving
    nmap <leader>w :w!<CR>
    
    " Fast editing of the .vimrc
    if MySys()=="windows"
    map <leader>e :e! ~\_vimrc<CR>
    else
    map <leader>e :e! ~/.vimrc<CR>
    endif
    
    " When vimrc is edited, reload it
    if MySys()=="windows"
    autocmd! bufwritepost _vimrc source ~\_vimrc
    else
    autocmd! bufwritepost .vimrc source ~/.vimrc
    endif
" }

" UI {
    " Set 7 lines to the cursors - when moving vertical..
    set so=7
    
    set wildmenu "Turn on WiLd menu
    set ruler "Always show current position
    set cmdheight=2
    set hid "Change buffer - without saving
    
    set backspace=eol,start,indent
    set whichwrap+=<,>,h,l
    
    set ignorecase "Ignore case when searching
    set smartcase
    
    set hlsearch
    set incsearch
    set nolazyredraw "Don't redraw while executing macros
    
    set magic "Set magic on, for regular expressions
    
    set showmatch
    set mat=2
    
    set noerrorbells
    set novisualbell
    ""set vb t_vb=
    set tm=500
    
    set nu
    
    "set cursorcolumn
    set cursorline
" }

" Colors and fonts {
    syntax enable
    
    " Set font according to system
    if MySys()=="mac"
      set gfn=Menlo:h14
      set shell=/bin/bash
    elseif MySys()=="windows"
      set gfn=Bitstream\ Vera\ Sans\ Mono:h10
    elseif MySys() == "linux"
      set gfn=Monospace\ 10
      set shell=/bin/bash
    endif
    
    if has("gui_running")
      set guioptions-=T
      set t_Co=256
      set background=dark
      colorscheme darkZ 
    else
      colorscheme zellner
      set background=dark
    endif
" }

" Files, backups {
    set encoding=utf8
    try
        lang en_US
    catch
    endtry
    
    set ffs=unix,dos,mac "Default file types
    
    set nobackup
    set nowb
    set noswapfile	
" }

" Text, tab and indent related {
    set expandtab
    set shiftwidth=4
    set tabstop=4
    set smarttab
    
    set lbr
    set tw=500
    
    set ai
    set si
    set wrap
" }

" Moving around, tabs and buffers {
    " Map space to / (search) and c-space to ? (backgwards search)
    "map <space> /
    "map <c-space> ?
    "map <silent> <leader><cr> :noh<cr>
    
    " Smart way to move btw. windows
    map <C-j> <C-W>j
    map <C-k> <C-W>k
    map <C-h> <C-W>h
    map <C-l> <C-W>l
    
    " Close the current buffer
    map <leader>bd :Bclose<cr>
    
    " Close all the buffers
    map <leader>ba :1,300 bd!<cr>
    
    " Use the arrows to something usefull
    "map <right> :bn<cr>
    "map <left> :bp<cr>
    
    " Tab configuration
    "map <leader>tn :tabnew<cr>
    "map <leader>te :tabedit 
    "map <leader>tc :tabclose<cr>
    "map <leader>tm :tabmove 
    
    " When pressing <leader>cd switch to the directory of the open buffer
    map <leader>cd :cd %:p:h<cr>
    
    
    command! Bclose call <SID>BufcloseCloseIt()
    function! <SID>BufcloseCloseIt()
       let l:currentBufNum = bufnr("%")
       let l:alternateBufNum = bufnr("#")
    
       if buflisted(l:alternateBufNum)
         buffer #
       else
         bnext
       endif
    
       if bufnr("%") == l:currentBufNum
         new
       endif
    
       if buflisted(l:currentBufNum)
         execute("bdelete! ".l:currentBufNum)
       endif
    endfunction
    
    " Specify the behavior when switching between buffers 
    try
      "set switchbuf=usetab
      "set stal=2
    catch
    endtry
" }

" Statusline {
    " Always hide the statusline
    set laststatus=2

    " Format the statusline
    set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c
" }

" Cope {
" Do :help cope if you are unsure what cope is. It's super useful!
    map <leader>cc :botright cope<cr>
    map <leader>n :cn<cr>
    map <leader>p :cp<cr>
" }

" bufExplorer plugin {
    let g:bufExplorerDefaultHelp=0
    let g:bufExplorerShowRelativePath=1
    map <leader>o :BufExplorer<CR>
" }

" Minibuffer plugin {
    let g:miniBufExplModSelTarge =1
    let g:miniBufExplorerMoreThanOne=2
    let g:miniBufExplUseSingleClick=1
    let g:miniBufExplMapWindowNavVim=1

    let g:bufExplorerSortBy="name"

    autocmd BufRead,BufNew :call UMiniBufExplorer

    map <leader>u :TMiniBufExplorer<CR>

    map <leader>da :DoxAuthor<CR>
    map <leader>df :Dox<CR>
" }
