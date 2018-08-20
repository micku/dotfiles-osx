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
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-vinegar'
Plug 'terryma/vim-expand-region'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'w0rp/ale'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'roxma/python-support.nvim'
Plug 'will133/vim-dirdiff'
Plug 'Shougo/vimfiler.vim'
Plug 'Shougo/unite.vim'
Plug 'ryanoasis/vim-devicons'
" Autocompletion
"Plug 'roxma/nvim-completion-manager' # Temporarly commented to silence an
"error
Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}
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
Plug 'ambv/black'

call plug#end()
"End vim-plug Scripts-------------------------
if !1 | finish | endif

" Enable lightline at startup
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
      \   'right': [ [ 'lineinfo', 'readonly', 'linter_warnings', 'linter_errors', 'linter_ok' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
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
      \ 'component_expand': {
      \   'linter_warnings': 'LightlineLinterWarnings',
      \   'linter_errors': 'LightlineLinterErrors',
      \   'linter_ok': 'LightlineLinterOK'
      \ },
      \ 'component_type': {
      \   'readonly': 'error',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_ok': 'ok'
      \ },
      \ 'separator': { 'left': "", 'right': "" },
      \ 'subseparator': { 'left': "|", 'right': "|" }
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
set autoread " Doesn't work, see comments: https://unix.stackexchange.com/a/149214/86007
 
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

if !has("gui_vimr")
  "set guifont=Mensch:h8
  "set guifont=Mensch\ 10
  set guifont=OperatorMono\ Nerd\ Font:h10
  if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
      set guifont=Meslo\ LG\ M\ DZ\ for\ Powerline:h11
    endif
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

" terminal emulator
tnoremap <Esc> <C-\><C-n>
highlight TermCursor ctermfg=red guifg=red
 
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

" make undo persistant
set undofile

" dirs for backup, undo and ...
set backupdir=$HOME/.vim/temp//
set undodir=$HOME/.vim/temp//
set directory=$HOME/.vim/temp//

" use <leader-space> to remove search higlight
nnoremap <leader><space> :noh<cr>

" use <leader-t> to find all TOD in Python code
noremap <Leader>t :noautocmd vimgrep /TODO/j **/*.py<CR>:cw<CR>

" netrw configuration
let g:netrw_liststyle = 3
set wildignore+=*.pyc

" VimFiler
let g:vimfiler_as_default_explorer=1
let g:vimfiler_tree_indentation = 2
let g:vimfiler_ignore_pattern = ['^\.DS_Store$', '*.pyc']

" Windows splitting
set splitbelow
set splitright

" Fixes wrong mapping of C-h in MacOS + Neovim
" https://github.com/neovim/neovim/issues/2048#issuecomment-92776095
if has('nvim')
  nmap <bs> :<c-u>TmuxNavigateLeft<cr>
endif
nmap <silent> <C-tab> <C-w>w
" TODO: Creating a new split in Netrw was helpful, but
" not working with terminal because of the autocmd below
"nmap <silent> <C-t><C-j> <C-w>s-
"nmap <silent> <C-t><C-k> <C-w>s-
"nmap <silent> <C-t><C-l> <C-w>v-
"nmap <silent> <C-t><C-s> <C-w>v-
nnoremap <C-t><C-j> <C-w>s
nnoremap <C-t><C-k> <C-w>s
nnoremap <C-t><C-l> <C-w>v
nnoremap <C-t><C-h> <C-w>v
tnoremap <C-t><C-j> <C-\><C-N><C-w>s
tnoremap <C-t><C-k> <C-\><C-N><C-w>s
tnoremap <C-t><C-l> <C-\><C-N><C-w>v
tnoremap <C-t><C-h> <C-\><C-N><C-w>v

nnoremap ˙ :vertical resize -5<CR>
nnoremap ¬ :vertical resize +5<CR>
nnoremap ∆ :vertical resize -5<CR>
nnoremap ˚ :vertical resize +5<CR>

tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
autocmd BufWinEnter,WinEnter term://* startinsert

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

" ALE
let g:ale_sign_column_always = 1

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:all_non_errors == 0 ? '' : printf('%d ⚠', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  return l:all_errors == 0 ? '' : printf('%d ⨯', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  return l:counts.total == 0 ? '✓' : ''
endfunction

autocmd User ALELint call lightline#update()

" fzf
let g:fzf_command_prefix = 'Fzf'
nnoremap <leader>- :FzfFiles!<cr>
nnoremap <leader>, :FzfAg!<cr>
nnoremap <leader>c :FzfCommits!<cr>
nnoremap <leader>f :FzfBLines<cr>
" To use fzf in Vim, add the following line to your .vimrc:
" set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf

" Black
let g:black_linelength=80

" nvim-completion-manager
" for python completions
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'jedi')
" language specific completions on markdown file
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'mistune')
" utils, optional
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'psutil')
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'setproctitle')
" Use <TAB> to select the popup menu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

