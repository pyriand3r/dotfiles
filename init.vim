scriptencoding utf-8

" ================================================================================
" ===                                  BASICS                                  ===
" ================================================================================

set number									" set absolut numbers 
set relativenumber					" set relative line number 
set cursorline							" Highlight current line
set nobackup  							"disable backup files
set noswapfile							"disable swap files (swp)
" set autochdir 							"always move into directory of opened file
set noexpandtab							"on pressing tab insert tab, no spaces
set copyindent							"
set preserveindent					"keep indentation of file (spaces if spaces, tabs if tabs)
set softtabstop=0
set tabstop=2								"show tabs with two spaces length
set shiftwidth=2						"when indenting with '>' use one tab

" activate autocompletion for tags in html files
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType markdown set omnifunc=htmlcomplete#CompleteTags

" Recognize .md files as markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown


" set indentation to 2 spaces
filetype plugin indent off

set clipboard=unnamed,unnamedplus
set listchars=tab:▸\ ,trail:·,nbsp:~,precedes:❮,extends:❯
set list                    " Display listchars
set nowrap                  " Don’t wrap long lines
set breakindent             " Indent continued lines after break
set showbreak=↪             " Show symbol for contiuned lines after break
set linebreak               " Don’t wrap long lines in the middle of a word
set scrolloff=5             " Display at least 3 lines above/below cursor
set sidescrolloff=5         " Display at least 3 columns right/left of cursor
set sidescroll=1            " Don’t put cursor in the mid. of the screen on hor. scroll
set mouse=a                 " Enable the use of mouse in all modes
set autoread                " Reload file if changed outside of vim
set hidden                  " Don’t unload abandoned buffers
set nostartofline           " Keep the cursor in the same column when moving
set nobackup                " Don’t create backups on save
set noswapfile              " Don’t create swap files
set nomodeline              " Don’t read modelines from files
set splitbelow              " Open hsplit below current window
set splitright              " Open vsplit right of current window
set ruler                   " Show line and column number
set showcmd                 " Show command in the bottom right of the screen
set laststatus=2            " Always show statusbar
set noshowmode              " Disable mode message, Lightline also has it
set encoding=utf-8          " Default character encoding
set textwidth=99            " Maximum width of text that is being inserted
set colorcolumn=+1,100,120   " Highlight these columns (+1 == textwidth)
set autoindent              " Automatically indent new lines
set incsearch               " Show matches while entering the search pattern
set ignorecase              " Ignore case while searching …
set smartcase               " … except when pattern contains an upper case character
set hlsearch                " Keep matches of previous search highlighted

" Return to the same line when you reopen a file.
augroup line_return
	autocmd!
	autocmd BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\     execute 'normal! g`"zvzz' |
		\ endif
augroup END



" ================================================================================
" ===                                  PLUGINS                                 ===
" ================================================================================

" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

" install missing plugins automatically, check for updates
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd!
    autocmd VimEnter * PlugInstall
endif

let g:coc_global_extensions = ['coc-tsserver', 'coc-eslint', 'coc-vetur', 'coc-css', 'coc-json', 'coc-html', 'coc-phpls']

call plug#begin('~/.config/nvim/plugged')
" === GENERAL ===
Plug '907th/vim-auto-save'								"autosave
Plug 'tpope/vim-fugitive'									"git support
Plug 'junegunn/fzf.vim'										"easy file opening, fuzzy finding
Plug 'itchyny/lightline.vim'							"status bar
Plug 'mengelbrecht/lightline-bufferline'	" Bufferline plugin for lightline
Plug 'jacoborus/tender.vim' 							" Lightline color theme
Plug 'jremmen/vim-ripgrep'								"ripgrep
Plug 'tpope/vim-eunuch'								"additional userfull commands
Plug 'scrooloose/nerdtree' 						"sidebar file browser with neat features
Plug 'Xuyuanp/nerdtree-git-plugin' 		"git icons on nerdtree
Plug 'ryanoasis/vim-devicons' "Icons for filetypes
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' "Colorize the nerdtree vim devicons
Plug 'terryma/vim-multiple-cursors' 	"use multiple cursors
Plug 'tomtom/tcomment_vim'						"toggle comment with g<c line and g<b block
Plug 'airblade/vim-gitgutter' 				"show changed lines in column
Plug 'tpope/vim-surround' 						"change add brakets
Plug 'Raimondi/delimitMate' 					"auto close brakets
Plug 'thisisrandy/vim-outdated-plugins' 	"checks for outdated plugins 

" === LANGUAGE SUPPORT ===
" intellisense language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" vue highlighting
Plug 'posva/vim-vue'
" typescript highlighting
Plug 'leafgarland/typescript-vim', {'for': 'typescript'}
Plug 'fatih/vim-go', {'do': 'GoUpdateBinaries', 'for': 'go'}
Plug 'StanAngeloff/php.vim' 				"PHP
" === MARKDOWN ===
"markdown highlighting
Plug 'plasticboy/vim-markdown'
" Plug 'gabrielelana/vim-markdown'
"markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

" === THEMES ===
" monokai pro theme
Plug 'phanviet/vim-monokai-pro'

call plug#end()

" =============================================================================
" ===                             PLUGINS_CONFIG                            ===
" =============================================================================

" ============================    vim-markdown    =============================
" disable spell checking
" let g:markdown_enable_spell_checking = 0

" ===============================   Coc.nvim  = ===============================
" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

"Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" ================================ NERDtree ===================================


" Open NERDTree automatically if vim starts up opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'bd' | exe 'NERDTree' argv()[0] |  exe 'cd '.argv()[0] | endif

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Close nerdtree when its the last window open

let g:NERDTreeShowHidden = 1  " Show hidden files/directories
let g:NERDTreeMinimalUI = 1   " Remove bookmarks and help text from NERDTree
let g:NERDTreeHijackNetrw = 0 " Use Nerdtree instead of netrw
let g:loaded_netrw       = 1  " Set the netrw is loaded flag
let g:loaded_netrwPlugin = 1  " Set the netrw plugin is loaded flag
let g:NERDTreeDirArrowExpandable = '▸' " Custom icons for expandable directories
let g:NERDTreeDirArrowCollapsible = '▾' " Custom icons for expanded directories
let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]','\.idea$[[dir]]', '\.sass-cache$'] " Hide certain files and directories from NERDTree
let g:NERDTreeQuitOnOpen = 1 " Nerdtree closes after file is opened"
let g:NERDTreeShowIgnoredStatus = 1 " Highlight .gitignored files
highlight! link NERDTreeFlags NERDTreeDir " Disable coloring for dirs,flags and links

" ================================ autosave ===================================
" activate globally
let g:auto_save = 1
" activate for specific filetypes only
"let g:auto_save = 0
"augroup ft_markdown
"  au!
"  au FileType markdown let b:auto_save = 1
"augroup END

" do not display save events
"let g:auto_save_silent = 1

" set autosave events
" possible values:
" 	InsertLeave		- leave the insert mode
"		TextChanged		- save after text was changed in normal mode
"		TextCahngedI	- save after text was changed in insert mode
"		CursorHold		- save every miliseconds as defined in 'updatetime' in normal mode
"		CursorHoldI   - save every miliseconds as defined in 'updatetime' in insert mode
"		CompleteDone	- trigger save after every completion event
let g:auto_save_events = ["InsertLeave", "TextChanged"]

" ================================== lightline ================================

let g:lightline = {}
let g:lightline.colorscheme = 'tender'
let g:lightline.active = {}
let g:lightline.active.left = [[ 'mode', 'paste' ],[ 'cocstatus', 'readonly', 'modified' ]] 
let g:lightline.component_function = {}
let g:lightline.component_function.gitbranch = 'fugitive#head'
let g:lightline.tabline = {}
let g:lightline.tabline.left = [['buffers']]
let g:lightline.tabline.right = [['gitbranch']]
let g:lightline.component_expand = {}
let g:lightline.component_expand.buffers = 'lightline#bufferline#buffers'
let g:lightline.component_expand.cocstatus = 'cocstatuss'
let g:lightline.component_type = {}
let g:lightline.component_type.buffers = 'tabsel'
let g:lightline.separator = {}
"let g:lightline.separator.left = ''
"let g:lightline.separator.right = '' 
"let g:lightline.subseparator = {}
"let g:lightline.subseparator.left = ''
"let g:lightline.subseparator.right = ''

let g:lightline#bufferline#shorten_path     = 1 " Show short path name of buffers
let g:lightline#bufferline#min_buffer_count = 1 " min value needed to show bufferline
let g:lightline#bufferline#unnamed          = '[No Name]' " Name from unnamed buffers

" ================================== VimGo ====================================

" auto import dependencies
let g:go_fmt_command = "goimports"

" highlight same words
let g:go_auto_sameids = 1

" syntax default highlighting
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_variable_declaration = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

"change definition to gopls
let g:go_def_mode = "gopls"

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

" ================================================================================
" ===                                  THEME                                   ===
" ================================================================================
" activate support for 24-bit colors
set termguicolors
" set theme
colorscheme monokai_pro

" ================================================================================
" ===                                KEYBINDINGS                               ===
" ================================================================================
let mapleader=","

"create horizontal/vertical split
noremap <leader>s :split<cr>
noremap <leader>v :vsplit<cr>

" fsf shortcuts
map ; :Files<CR>
map <leader>b :Buffers<CR>

" nerdtree
map <leader>n :NERDTreeToggle<CR>

" tcomment
map <leader>c :TComment<CR>
map <leader>l :TCommentBlock<CR>

let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

