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
set textwidth=79            " Maximum width of text that is being inserted
set colorcolumn=+1,80,101   " Highlight these columns (+1 == textwidth)
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

let g:coc_global_extensions = ['coc-tsserver', 'coc-eslint', 'coc-vetur', 'coc-css', 'coc-json', 'coc-html']

call plug#begin('~/.config/nvim/plugged')
" === GENERAL ===
" autosave
Plug '907th/vim-auto-save'					"autosave
Plug 'tpope/vim-fugitive'						"git support
Plug 'junegunn/fzf.vim'							"easy file opening, fuzzy finding
Plug 'itchyny/lightline.vim'				"status bar
Plug 'jremmen/vim-ripgrep'					"ripgrep
Plug 'tpope/vim-eunuch'							"additional userfull commands
"Plug 'tpope/vim-vinegar'						"simple file browser
Plug 'scrooloose/nerdtree' 					"sidebar file browser with neat features
Plug 'Xuyuanp/nerdtree-git-plugin' 	"git icons on nerdtree
Plug 'terryma/vim-multiple-cursors' "use multiple cursors
Plug 'tomtom/tcomment_vim'					"toggle comment with g<c line and g<b block
Plug 'tweekmonster/braceless.vim'		"show indent guides
Plug 'airblade/vim-gitgutter' 			"show changed lines in column
Plug 'tpope/vim-surround' 					"change add brakets
Plug 'Raimondi/delimitMate' 				"auto close brakets

" === LANGUAGE SUPPORT ===
" intellisense language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" vue highlighting
Plug 'posva/vim-vue'
" typescript highlighting
Plug 'leafgarland/typescript-vim', {'for': 'typescript'}
Plug 'fatih/vim-go', {'do': 'GoUpdateBinaries', 'for': 'go'}

" === MARKDOWN ===
"markdown highlighting
"Plug 'plasticboy/vim-markdown'
Plug 'gabrielelana/vim-markdown'
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
let g:markdown_enable_spell_checking = 0

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
" Open NERDtree automatically on startup
" Close nvim is NERDtree is the only open buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeQuitOnOpen=1 	"close nerdtree after file has been opened
" === git-plugin ===
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

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
let g:lightline = {
	\ 'active': {
	\   'left': [['mode', 'paste'], ['virtualenv', 'relativepath'], ['readonly', 'modified']],
	\   'right': [['percent'], ['lineinfo'],
	\             ['filetype', 'fileencoding', 'fileformat', 'indentation']]
	\ },
	\ 'inactive': {
	\   'left': [['readonly', 'relativepath', 'modified']],
	\   'right': [['percent'], ['lineinfo']]
	\ },
	\ 'component_function': {
	\   'indentation': 'LlIndentation',
	\   'virtualenv': 'virtualenv#statusline',
	\ }
	\}

function! LlIndentation()
	let text = (&et ? 's' : 't').':'.&tabstop
	return winwidth('.') > 70 ? text : ''
endfunction


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
map <leader>p :Buffers<CR>

" nerdtree
map <leader>n :NERDTreeToggle<CR>

" tcomment
map <leader>c :TComment<CR>
map <leader>l :TCommentBlock<CR>
