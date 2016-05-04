" VIM Configuration File
" Author: Abhijith Tirumala Kumara

filetype plugin indent on   " set filetype detection on
syntax on                   " turn syntax highlighting on

set t_Co=256                " terminal colors
set t_vb=
set background=dark
set nobackup
set nowritebackup
set wildmode=longest:full
set wildmenu
set number
set numberwidth=5
set ignorecase
set smartcase
set showmatch               " highlight matching braces
set showmatch               " briefly jump to matching bracket
set visualbell              " supress the annoying bell on opening bracket, wtf...
" set number                " turn line numbers on
" set autochdir               " will automatically change the directory to the dir where the file is.
set autoread                " auto re-read files changed on disk to disable per buffer, set bt=nowrite
set autoindent              " use indentation of previous line
set smartindent             " use intelligent indentation for C
set textwidth=120           " wrap lines at 120 chars.  Make it 0 to disable
set colorcolumn=120,121     " set a nice indicator of 120 char width border
set nocompatible            " disable vi compatibility (emulation of old bugs)
set scrolloff=5             "show +/- N lines around current line
set whichwrap+=<,>,h,l,[,]  " allows left right arrow keys,wrap lines to move
set matchtime=3             " match time in 10ths of a second
set laststatus=1            " make it =2 to show always
set completeopt=menuone,longest       " completion menu opts
set comments=sl:/*,mb:\ *,elx:\ */    " intelligent comments
set backspace=indent,eol,start        " allow backspacing over everything in insert mode


" Set up indenting/tabs/spaces
set tabstop=3               " spaces per tab when inserting, ie tab width is 4 spaces
set shiftwidth=3            " spaces to move on >> or << or visual-mode > or <
set expandtab               " write actual spaces for tabs, ie expand tabs to spaces
set timeoutlen=500          " timeout while waiting on ambiguous cmds (also on <Leader> cmds)

" Searching configs
set incsearch               " do incremental searching
set hlsearch                " higlight search results

"set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" Persistent undo.. yes plz.
set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

colorscheme murphy

" Install OmniCppComplete like described on http://vim.wikia.com/wiki/C++_code_completion
" This offers intelligent C++ completion when typing \u2018.\u2019 \u2018->\u2019 or <C-o>
" Load standard tag files
"set tags+=~/.vim/tags/cpp
"set tags+=~/.vim/tags/gl
"set tags+=~/.vim/tags/sdl
"set tags+=~/.vim/tags/qt4

" Enhanced keyboard mappings
"nmap <F2> :w<CR>                  " in normal mode F2 will save the file
"imap <F2> <ESC>:w<CR>i            " in insert mode F2 will exit insert, save, enters insert again
"map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>   " switch between header/source with F4
"map <F5> :!ctags -R \u2013c++-kinds=+p \u2013fields=+iaS \u2013extra=+q .<CR>  " recreate tags file with F5
"map <F6> :Dox<CR>                 " create doxygen comment
"map <F7> :make<CR>                " build using makeprg with <F7>
"map <S-F7> :make clean all<CR>    " build using makeprg with <S-F7>
"map <F12> <C-]>                   " goto definition with F12


"" in diff mode we use the spell check keys for merging
"if &diff
"  \u201d diff settings
"  map <M-Down> ]c
"  map <M-Up> [c
"  map <M-Left> do
"  map <M-Right> dp
"  map <F9> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg
"else
"  " spell settings
"  :setlocal spell spelllang=en
"  " set the spellfile - folders must exist
"  set spellfile=~/.vim/spellfile.add
"  map <M-Down> ]s
"  map <M-Up> [s
"endif

if (has("win32"))
  set fileformats=dos,unix
else
  set fileformats=unix,dos
endif

" Map <ESC> to clear out search highlighting (echo clears the :noh)
"noremap <silent><esc> <esc>:noh<CR><esc>

" set dictionary for spelling and word-completion (^X^K)
function! AddToDict(file)
  if filereadable(expand(a:file))
    let l:cmd = printf("set dictionary+=%s", a:file)
    exe l:cmd
  endif
endfunction

call AddToDict("/usr/share/dict/words")
call AddToDict("/usr/share/dict/propernames")
call AddToDict("/usr/share/dict/eign")
call AddToDict("/usr/share/dict/freebsd")

" Custom commands using the <Leader>foo method
let mapleader = ","
nnoremap <silent>ll :setlocal list!<CR>
" View Help on current word under cursor in new tab
map <silent> <Leader>ht :tab help <c-r>=expand("<cword>")<CR><CR>
" View Help on current word under cursor (default split or reuse)
map <silent> <Leader>he :help <c-r>=expand("<cword>")<CR><CR>
" Open directory view of pwd of current open doc
map <silent> <Leader>dn :new %:p:h<CR>
map <silent> <Leader>dt :tabnew %:p:h<CR>


" Always open files under cursor in new tab
map gf :tabnew <cfile><CR>


" Safer way to do cabbrev that won't cause issues elsewhere in a command (only
" at start.
function! Single_quote(str)
  return "'" . substitute(copy(a:str), "'", "''", 'g') . "'"
endfunction

function! Cabbrev(key, value)
  exe printf('cabbrev <expr> %s (getcmdtype() == ":" && getcmdpos() <= %d) ? %s : %s',
    \ a:key, 1+len(a:key), Single_quote(a:value), Single_quote(a:key))
endfunction

call Cabbrev('Q','q')
call Cabbrev('Qa','qa')
call Cabbrev('QA','qA')
call Cabbrev('qA','qA')
call Cabbrev('W','w')
call Cabbrev('Wq','wq')
call Cabbrev('WQ','wq')
call Cabbrev('wQ','wq')
call Cabbrev('E','e')
call Cabbrev('ht','tab help')
call Cabbrev('hs','help')
call Cabbrev('et','tabnew')

" Leave this last to clear out highlighting from anything...
exec "noh"
