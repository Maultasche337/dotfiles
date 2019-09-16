"----NeoBundle------
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'scrooloose/NERDTree'
NeoBundle 'jlanzarotta/bufexplorer'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'wavded/vim-stylus'
NeoBundle 'groenewege/vim-less'
NeoBundle 'toyamarinyon/vim-swift'
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'matt-deacalion/vim-systemd-syntax'
NeoBundle 'nginx.vim'
NeoBundle 'tomlion/vim-solidity'
NeoBundle 'cespare/vim-toml'

call neobundle#end()

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

"---- Settings -----
colorscheme jellybeans
filetype plugin indent on "detect filetype via plugins
let NERDTreeShowHidden=1
set autoindent "automatic intendation
set directory=/tmp "Location for .swp files
set expandtab "replace tabs with space
"set foldmethod=indent "auto fold everything by indention
set ignorecase "ignore case sensitive in search
set hlsearch "higlight search results
set nobackup "dont write backup files
set noerrorbells visualbell t_vb= "disable error bell and flashing
set number "show line numbers
set pastetoggle=<F10> "in insert mode toggle paste
set shiftwidth=2
set smartindent
set softtabstop=2
set wildmenu "tab filename completion
set wildmode=longest,list "tab filename completion
syntax on "Syntax highlighting on
" add jbuilder syntax highlighting
au BufNewFile,BufRead *.json.jbuilder set ft=ruby
au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif
let g:jsx_ext_required = 0 " Active JSX highlighting also for .js files

" Graphical VIM in general
let s:uname = system("uname")
if has("gui_running")
  "GUI Running
  :set guioptions-=m  "remove menu bar
  :set guioptions-=T  "remove toolbar
  :set guioptions-=r  "remove right-hand scroll bar
  :set guioptions-=L  "remove left-hand scroll bar
  set guifont=Monospace\ 9 "Set font for gvim, macvim, not used in terminal
  if s:uname == "Darwin\n"
    set lines=60 columns=250
  elseif s:uname == "Linux\n"
    set guifont=Ubuntu\ Mono\ 12 "Set font for gvim, macvim, not used in terminal
    set lines=56 columns=141
  else
    set lines=60 columns=150
  endif
else
  "No GUI Running
  if s:uname == "Linux\n"
    let g:NERDTreeDirArrows=0 "weird characters in NERDTree in debian w/out this
  endif
endif

" When running inside gnome-terminal
if $COLORTERM == 'gnome-terminal'
  set t_Co=256 "Set colors to 256
endif

"---- Folding
set foldmethod=syntax
set foldlevelstart=100
let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML

"---- Shortcuts
"example  shortcut, blubbh expands to the text in insert mode
"iabbrev blubb bla blubb muh m

"---- Keyboard mapping
let mapleader = ','
imap ,e <esc>
nmap <LEADER>ev :tabedit $MYVIMRC<cr>
nmap <LEADER>nt :NERDTreeToggle
nmap <space> :
nmap <F11> :set nonumber<cr>
nmap <F12> :set number<cr>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"--- autoclose brackets
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}
inoremap        (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

"---- Auto Commands
if has("autocmd")
  autocmd GUIEnter * set visualbell t_vb= "disable error bell and flashing
  autocmd bufwritepost .vimrc source $MYVIMRC "Source the vimrc file after saving it
endif
