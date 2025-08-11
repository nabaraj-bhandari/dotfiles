" === Basic Settings ===
set nocompatible
filetype plugin indent on
syntax enable
set encoding=utf-8
set mouse=a
set clipboard=unnamedplus

" === Interface ===
set number
set relativenumber
set cursorline
set showmatch
set showcmd
set cmdheight=2
set laststatus=2
set signcolumn=yes

" === Search ===
set hlsearch
set incsearch
set ignorecase
set smartcase

" === Tabs and Indent ===
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent

" === Editing ===
set wrap
set linebreak
set backspace=indent,eol,start
set undofile
set swapfile
set timeoutlen=500
set updatetime=300

" === Colors ===
if has("termguicolors")
  set termguicolors
endif
colorscheme desert

" === Key mappings ===
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
vnoremap < <gv
vnoremap > >gv
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" === Plugins ===
call plug#begin('~/.vim/plugged')

" Sensible defaults
Plug 'tpope/vim-sensible'

" File explorer
Plug 'preservim/nerdtree'

" Git gutter signs
Plug 'airblade/vim-gitgutter'

" Status line
Plug 'itchyny/lightline.vim'

" Autocomplete (YouCompleteMe or coc.nvim recommended)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntax and lint for JS/TS/React/HTML/CSS with coc extensions

" Treesitter for enhanced syntax highlighting (optional)
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

" === Coc.nvim configuration ===
" Use coc extensions for Python, C, C++, JS, TS, HTML, CSS, React (jsx, tsx)
" You can install these extensions after vim starts via :CocInstall
" Example:
" :CocInstall coc-python coc-clangd coc-tsserver coc-html coc-css coc-json coc-eslint coc-prettier

" Set up completion shortcuts
inoremap <silent><expr> <C-Space> coc#refresh()

" Use <CR> to confirm completion, <Tab> to navigate
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use K to show documentation on hover
nnoremap <silent> K :call CocActionAsync('doHover')<CR>

" === NERDTree toggle ===
nnoremap <leader>n :NERDTreeToggle<CR>

" === Lightline config ===
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" === Treesitter setup ===
" You will need to install nvim to use this part
" For normal vim you can omit or replace with syntax on

" === Filetype-specific settings ===
autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType c,cpp setlocal tabstop=4 shiftwidth=4 noexpandtab
autocmd FileType javascript,typescript,html,css,tsx,jsx setlocal tabstop=2 shiftwidth=2 expandtab

" === Linting and Formatting (via coc extensions) ===
" You can configure coc-settings.json for prettier, eslint, black, clang-format

" === Misc ===
set completeopt=menuone,noinsert,noselect

