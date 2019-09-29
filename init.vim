scriptencoding utf-8

" ================================================================================
" ===                                  BASICS                                  ===
" ================================================================================

" Set line numbering and relative line numbering
" nu = absolute line numbering
" rnu = relative line numbering
set nu rnu

" defaults are awful messy, leaving .swp files everywhere if the editor
" isn’t closed properly. This can save you a lot of time.
set nobackup  "disable backup files
set noswapfile "disable swap files (swp)

" set nvim to always move into directory of opened file
set autochdir

" activate autocompletion for tags in html files
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType markdown set omnifunc=htmlcomplete#CompleteTags

" Recognize .md files as markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown

" On pressing tab insert tab
set noexpandtab

set copyindent

set preserveindent
" show existing tabs with 2 spaces
set softtabstop=0
set tabstop=2
" when indenting with '>' use 1 tab
set shiftwidth=2

" set indentation to 2 spaces
filetype plugin indent off
" On pressing tab, insert 2 spaces
"set expandtab
" show existing tab with 2 spaces width
"set tabstop=2
"set softtabstop=2
" when indenting with '>', use 2 spaces width
"se shiftwidth=2

" === autoclose brackets ===
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

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
" snippets/autocompletion
Plug 'SirVer/ultisnips'  
Plug 'honza/vim-snippets'
"distraction free mode  
Plug 'junegunn/goyo.vim'
"dimm lines execpt active one
Plug 'junegunn/limelight.vim'
" autosave
Plug '907th/vim-auto-save'
" fuzzy finding, open buffer list, floating menues
Plug 'Shougo/denite.nvim'
"sidebar file/folder tree
Plug 'scrooloose/nerdtree'
"NERDtree git flags
Plug 'Xuyuanp/nerdtree-git-plugin'
"Git support
Plug 'tpope/vim-fugitive'

" === LANGUAGE SUPPORT ===
" intellisense language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" vue highlighting
Plug 'posva/vim-vue'
" typescript highlighting
Plug 'leafgarland/typescript-vim'

" === MARKDOWN ===
"markdown highlighting
"Plug 'plasticboy/vim-markdown'
Plug 'gabrielelana/vim-markdown'
"markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

" === THEMES ===
" monokai pro theme
Plug 'phanviet/vim-monokai-pro'

call plug#end()

" ================================================================================
" ===                               PLUGINS_CONFIG                             ===
" ================================================================================
" === ultisnips ===
" Trigger configuration for ultisnips. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-tab>"  " use <Tab> trigger autocompletion
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" === Limelight ===
" Toggle Limelight together with distraction free mode
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Wrap in try/catch to avoid errors on initial install before plugin is available
try
" === Denite setup ==="
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" Use ripgrep in place of "grep"
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

" Open file commands
call denite#custom#map('insert,normal', "<C-t>", '<denite:do_action:tabopen>')
call denite#custom#map('insert,normal', "<C-v>", '<denite:do_action:vsplit>')
call denite#custom#map('insert,normal', "<C-h>", '<denite:do_action:split>')

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight
let s:denite_options = {'default' : {
\ 'split': 'floating',
\ 'start_filter': 1,
\ 'auto_resize': 1,
\ 'source_names': 'short',
\ 'prompt': 'λ:',
\ 'statusline': 0,
\ 'highlight_matched_char': 'WildMenu',
\ 'highlight_matched_range': 'Visual',
\ 'highlight_window_background': 'Visual',
\ 'highlight_filter_background': 'StatusLine',
\ 'highlight_prompt': 'StatusLine',
\ 'winrow': 1,
\ 'vertical_preview': 1
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)
catch
  echo 'Denite not installed. It should work after running :PlugInstall'
endtry

" === Coc.nvim ===
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

" === NERDtree ===
" Open NERDtree automatically on startup
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" Close nvim is NERDtree is the only open buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" === autosave
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

" === Denite shorcuts ===
"   ;         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nmap ; :Denite buffer<CR>
nmap <leader>t :DeniteProjectDir file/rec<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:.<CR>

" Switch modes with C-l (like esc but won't quit)
call denite#custom#map(
  \ 'normal',
  \ '<C-l>',
  \ '<denite:enter_mode:insert>',
  \ 'noremap'
  \)
call denite#custom#map(
  \ 'insert',
  \ '<C-l>',
  \ '<denite:enter_mode:normal>',
  \ 'noremap'
  \)

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o>
  \ <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
  \ denite#do_map('open_filter_buffer')
endfunction

" === NERDtree ===
" Open NERDtree
Plug 'neoclide/coc-vetur'
map <C-n> :NERDTreeToggle<CR><Paste>

