if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.vim

"vim-plug Scripts-----------------------------
" Check if vim-plug is installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" List of plugins
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-vinegar'
Plug 'Shougo/unite.vim'
Plug 'terryma/vim-expand-region'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-syntastic/syntastic'
Plug 'editorconfig/editorconfig-vim'
Plug 'neomake/neomake'
" Auto save
Plug '907th/vim-auto-save'
" Web dev
Plug 'mattn/emmet-vim'
Plug 'groenewege/vim-less'
Plug 'skammer/vim-css-color'
Plug 'hail2u/vim-css3-syntax'
Plug 'mxw/vim-jsx'
" Languages
Plug 'fatih/vim-go'
Plug 'pangloss/vim-javascript'
Plug 'leshill/vim-json'

call plug#end()
"End vim-plug Scripts-------------------------
if !1 | finish | endif

" run JSHint when a file with .js extension is saved
" this requires the jsHint2 plugin
autocmd! BufWritePost,BufEnter * Neomake
let g:neomake_javascript_enabled_makers = ['eslint']

" Enable lightline at startup
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive'
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"\ue0a0":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))'
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }
function! MyFugitive()
        if &ft !~? 'vimfiler' && exists('*fugitive#head')
                let _ = fugitive#head()
                return strlen(_) ? '⎇ '._ : ''
        endif
        return ''
endfunction
set noshowmode

" ---------------------- USABILITY CONFIGURATION ----------------------
"  Basic and pretty much needed settings to provide a solid base for
"  source code editting

" Displays an incomplete command in the lower right of the window
set showcmd

" Show cursor position in lower right of the window
set ruler
 
" turn on syntax highlighting
syntax on
" and show line numbers relative to cursor
set number
set relativenumber
 
" make vim try to detect file types and load plugins for them
filetype on
filetype plugin on
filetype indent on
 
" reload files changed outside vim
set autoread         
 
" encoding is utf 8
set encoding=utf-8
set fileencoding=utf-8
 
" enable matchit plugin which ships with vim and greatly enhances '%'
runtime macros/matchit.vim
 
" by default, in insert mode backspace won't delete over line breaks, or 
" automatically-inserted indentation, let's change that
set backspace=indent,eol,start
 
" dont't unload buffers when they are abandoned, instead stay in the
" background
set hidden
 
" set unix line endings
set fileformat=unix
" when reading files try unix line endings then dos, also use unix for new
" buffers
set fileformats=unix,dos
 
" save up to 100 marks, enable capital marks
set viminfo='100,f1
 
" screen will not be redrawn while running macros, registers or other
" non-typed comments
set lazyredraw

" set , as mapleader
let mapleader = ","

" windows like clipboard
" yank to and paste from the clipboard without prepending "* to commands
let &clipboard = has('unnamedplus') ? 'unnamedplus' : 'unnamed'

" keep the cursor visible within 3 lines when scrolling
set scrolloff=3

" indentation
set expandtab       " use spaces instead of tabs
set autoindent      " autoindent based on line above, works most of the time
set smartindent     " smarter indent for C-like languages
set shiftwidth=4    " when reading, tabs are 4 spaces
set softtabstop=4   " in insert mode, tabs are 4 spaces
 
" hide unnecessary gui in gVim
if has("gui_running")
    set guioptions-=m  " remove menu bar
    set guioptions-=T  " remove toolbar
    set guioptions-=r  " remove right-hand scroll bar
    set guioptions-=L  " remove left-hand scroll bar
end

set guifont=Mensch:h8
set guifont=Mensch\ 10
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    set guifont=Meslo\ LG\ M\ DZ\ for\ Powerline:h11
  endif
endif
set background=dark
if has("gui_macvim")
    set transparency=5
end
let g:jellybeans_overrides = {
\    'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
\}
colorscheme jellybeans
 
" Auto save
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode

" search settings
set incsearch        " find the next match as we type the search
set hlsearch         " hilight searches by default
set ignorecase       " Do case insensitive matching
set smartcase        " With ignorecase, if all lowercase, case insensitive

" use <C-Space> for Vim's keyword autocomplete
"  ...in the terminal
inoremap <Nul> <C-n>
"  ...and in gui mode
inoremap <C-Space> <C-n>
 
" on file types...
"   .md files are markdown files
autocmd BufNewFile,BufRead *.md setlocal ft=markdown
"   .twig files use html syntax
autocmd BufNewFile,BufRead *.twig setlocal ft=html
"   .less files use less syntax
autocmd BufNewFile,BufRead *.less setlocal ft=less
"   .jade files use jade syntax
autocmd BufNewFile,BufRead *.jade setlocal ft=jade
"   .go files are golang files
autocmd BufNewFile,BufRead *.go setlocal ft=go

" golang settings
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_autosave = 1
let g:go_metalinter_autosave = 1
let g:go_fmt_command = "goimports"

let g:auto_save_presave_hook = 'call AbortIfGolang()'

function! AbortIfGolang()
  if &filetype == 'go'
    let g:auto_save_abort = 1
  endif
endfunction

if &filetype == 'go'
  let g:auto_save_abort = 1
endif

" jsx settings
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" syntastic + golang
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck', 'gometalinter']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_list_type = "quickfix"

" syntastic + js
let g:syntastic_javascript_checkers = ['eslint']

" make undo persistant
set undofile

" dirs for backup, undo and ...
set backupdir=$HOME/.vim/temp//
set undodir=$HOME/.vim/temp//
set directory=$HOME/.vim/temp//

" use <leader-space> to remove search higlight
nnoremap <leader><space> :noh<cr>

" netrw configuration
let g:netrw_liststyle = 3
set wildignore+=*.pyc

" Windows splitting
set splitbelow
set splitright

" Fixes wrong mapping of C-h in MacOS + Neovim
" https://github.com/neovim/neovim/issues/2048#issuecomment-92776095
if has('nvim')
  nmap <bs> :<c-u>TmuxNavigateLeft<cr>
endif
nmap <silent> <C-tab> <C-w>w
nmap <silent> <C-t><C-j> <C-w>s-
nmap <silent> <C-t><C-k> <C-w>s-
nmap <silent> <C-t><C-l> <C-w>v-
nmap <silent> <C-t><C-s> <C-w>v-

" vim-expand-region custom config
vmap v <Plug>(expand_region_expand)

" golang specific mappings
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>e <Plug>(go-rename)
au FileType go nmap <F12> <Plug>(go-def)
au FileType go nmap <leader>ds <Plug>(go-def-split)
au FileType go nmap <leader>dv <Plug>(go-def-vertical)

" Does not work
"au FileType go nmap <Leader>l :!gox -osarch="linux/amd64" -output="bin\{{.Dir}}_{{.OS}}_{{.Arch}}" ./...<cr>

" set the cursor to a vertical line in insert mode and a solid block
" in command mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

    " upon hitting escape to change modes,
    " send successive move-left and move-right
    " commands to immediately redraw the cursor
    inoremap <special> <Esc> <Esc>hl

    " don't blink the cursor
    set guicursor+=i:blinkwait0
else
    let &t_SI = "\<esc>\<esc>\<esc>]50;CursorShape=1\x7\<esc>\\"
    let &t_EI = "\<esc>\<esc>\<esc>]50;CursorShape=0\x7\<esc>\\"
endif

" Split panes resize
nnoremap <silent> <Leader>s :resize -5<CR>
nnoremap <silent> <Leader>w :resize +5<CR>
nnoremap <silent> <Leader>d :vertical resize -5<CR>
nnoremap <silent> <Leader>a :vertical resize +5<CR>

" Enable mouse scroll in terminal
if has('mouse')
    set mouse=a
endif

" Move by displayed lines, not by fisical lines
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$
