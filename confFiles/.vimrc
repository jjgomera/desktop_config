" Fisa-vim-config, a config for both Vim and NeoVim
" http://vim.fisadev.com
" version: 12.0.1

" To use fancy symbols wherever possible, change this setting from 0 to 1
" and use a font from https://github.com/ryanoasis/nerd-fonts in your terminal 
" (if you aren't using one of those fonts, you will see funny characters here. 
" Turst me, they look nice when using one of those fonts).
let fancy_symbols_enabled = 1


set encoding=utf-8
let using_neovim = has('nvim')
let using_vim = !using_neovim
let mapleader = "ñ"

" ============================================================================
" Vim-plug initialization
" Avoid modifying this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
if using_neovim
    let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
else
    let vim_plug_path = expand('~/.vim/autoload/plug.vim')
endif
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    if using_neovim
        silent !mkdir -p ~/.config/nvim/autoload
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        silent !mkdir -p ~/.vim/autoload
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the config down below 
" as you wish :)
" IMPORTANT: some things in the config are vim or neovim specific. It's easy 
" to spot, they are inside `if using_vim` or `if using_neovim` blocks.

" ============================================================================
" Active plugins
" You can disable or add new ones here:

" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
if using_neovim
    call plug#begin("~/.config/nvim/plugged")
else
    call plug#begin("~/.vim/plugged")
endif

" Now the actual plugins:

" Gvim colorscheme
Plug 'vim-scripts/Wombat'

" Code commenter
Plug 'scrooloose/nerdcommenter'
"\c<space>: Alterna comentario de linea
"\cA: Inserta comentario al final de linea

" Better file browser
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Class/module browser
Plug 'majutsushi/tagbar'
"<F4>: alterna barra de etiquetas
"
" Search results counter
Plug 'vim-scripts/IndexedSearch'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Code and files fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Pending tasks list
Plug 'fisadev/FixedTaskList.vim'
"<F2>: Muestra lista de tareas pendientes

" Yank history navigation
Plug 'vim-scripts/YankRing.vim'

" Ack code search (requires ack installed in the system)
Plug 'mileszs/ack.vim'

" Paint css colors with the real color
Plug 'lilydjwg/colorizer'

" Nice icons in the file explorer and file type status line.
Plug 'ryanoasis/vim-devicons'

" Surround
Plug 'tpope/vim-surround'

" Window chooser
Plug 't9md/vim-choosewin'

" Automatically close parenthesis, etc
Plug 'Townk/vim-autoclose'

" Git integration
Plug 'tpope/vim-fugitive'
" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'

" Async autocompletion
if using_neovim && vim_plug_just_installed
    Plug 'Shougo/deoplete.nvim', {'do': ':autocmd VimEnter * UpdateRemotePlugins'}
else
    Plug 'Shougo/deoplete.nvim'

    " tabnine autocompletion
    "Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
endif

" deoplete dependence
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

" Python autocompletion
Plug 'deoplete-plugins/deoplete-jedi'

" Just to add the python go-to-definition and similar features, autocompletion
" from this plugin is disabled
Plug 'davidhalter/jedi-vim'

" Completion from other opened files
Plug 'Shougo/context_filetype.vim'

" Python and other languages code checker
"Plug 'scrooloose/syntastic'

if using_vim
    " Consoles as buffers (neovim has its own consoles as buffers)
    Plug 'gingerhot/conque-term-vim'
    " XML/HTML tags navigation (neovim has its own)
    Plug 'vim-scripts/matchit.zip'
endif

" Google translate
Plug 'echuraev/translate-shell.vim'

" Csv editing
Plug 'chrisbra/csv.vim'

" Icon editor
Plug 'tpope/vim-afterimage'

" zea documentation
Plug 'KabbAmine/zeavim'
" ñz search current world in zea

" coverage python code
Plug 'alfredodeza/coveragepy.vim'

" Pytest on fly
Plug 'alfredodeza/pytest.vim'

" REst support
" Plug 'Rykka/riv.vim'
" Plug 'Rykka/InstantRst'

" Highlight matching html tags
"Plug 'valloric/MatchTagAlways'
" Generate html in a simple way
"Plug 'mattn/emmet-vim'

" Copilot
Plug 'github/copilot.vim'

"Debugger
"Plug 'puremourning/vimspector'

" Linters
Plug 'neomake/neomake'

" Indent text object, useful for select, delete, etc
Plug 'michaeljsmith/vim-indent-object'
" Indentation based movements
Plug 'jeetsukumaran/vim-indentwise'

" Better language packs
"Plug 'sheerun/vim-polyglot'

" Automatically sort python imports
Plug 'fisadev/vim-isort'


" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

if using_vim
    " A bunch of things that are set by default in neovim, but not in vim

    " no vi-compatible
    set nocompatible

    " allow plugins by file type (required for plugins!)
    filetype on
    filetype plugin on
    filetype indent on

    " always show status bar
    set ls=2

    " incremental search
    set incsearch
    " highlighted search results
    set hlsearch

    " syntax highlight on
    syntax on

    " better backup, swap and undos storage for vim (nvim has nice ones by
    " default)
    set directory=~/.vim/dirs/tmp     " directory to place swap files in
    set backup                        " make backup files
    set backupdir=~/.vim/dirs/backups " where to put backup files
    set undofile                      " persistent undos - undo after you re-open the file
    set undodir=~/.vim/dirs/undos
    set viminfo+=n~/.vim/dirs/viminfo
    " create needed directories if they don't exist
    if !isdirectory(&backupdir)
        call mkdir(&backupdir, "p")
    endif
    if !isdirectory(&directory)
        call mkdir(&directory, "p")
    endif
    if !isdirectory(&undodir)
        call mkdir(&undodir, "p")
    endif
end

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" show line numbers
set nu

" remove ugly vertical lines on window division
set fillchars+=vert:\ 

" use 256 colors when possible
if has('gui_running') || using_neovim || (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256')
    if !has('gui_running')
        let &t_Co = 256
    endif
    "colorscheme vim-monokai-tasty
    colorscheme wombat
else
    colorscheme delek
endif

" ============================================================================
" Plugins settings and mappings
" Edit them as you wish.


" Tagbar -----------------------------

" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1


" NERDTree -----------------------------

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" Enable folder icons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

" Fix directory colors
highlight! link NERDTreeFlags NERDTreeDir

" Remove expandable arrow
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
let NERDTreeDirArrowExpandable = "\u00a0"
let NERDTreeDirArrowCollapsible = "\u00a0"
let NERDTreeNodeDelimiter = "\x07"

" Autorefresh on tree focus
function! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfunction

autocmd BufEnter * call NERDTreeRefresh()


" nerdcommenter ----------------------------------
"
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'both'


" Tasklist ------------------------------

" show pending tasks list
map <F2> :TaskList<CR>


" Fzf ------------------------------

" file finder mapping
nmap ,e :Files<CR>
" tags (symbols) in current file finder mapping
nmap ,g :BTag<CR>
" the same, but with the word under the cursor pre filled
nmap ,wg :execute ":BTag " . expand('<cword>')<CR>
" tags (symbols) in all files finder mapping
nmap ,G :Tags<CR>
" the same, but with the word under the cursor pre filled
nmap ,wG :execute ":Tags " . expand('<cword>')<CR>
" general code finder in current file mapping
nmap ,f :BLines<CR>
" the same, but with the word under the cursor pre filled
nmap ,wf :execute ":BLines " . expand('<cword>')<CR>
" general code finder in all files mapping
nmap ,F :Lines<CR>
" the same, but with the word under the cursor pre filled
nmap ,wF :execute ":Lines " . expand('<cword>')<CR>
" commands finder mapping
nmap ,c :Commands<CR>


" Airline ------------------------------

let g:airline_powerline_fonts = 1
let g:airline_theme = 'deus'
let g:airline#extensions#whitespace#enabled = 0

" Fancy Symbols!!
 
if fancy_symbols_enabled
    let g:webdevicons_enable = 1

    " custom airline symbols
    if !exists('g:airline_symbols')
       let g:airline_symbols = {}
    endif
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = '⭠'
    let g:airline_symbols.readonly = '⭤'
    let g:airline_symbols.linenr = '⭡'
else
    let g:webdevicons_enable = 0
endif

"Acorta modo en los casos más comunes
let g:airline_mode_map = {
      \ 'i'      : 'I',
      \ 'n'      : 'N',
      \ 'R'      : 'R',
      \ }

let g:airline#extensions#hunks#non_zero_only = 1


" Yankring -------------------------------

nnoremap <silent> <F12> :YRShow<CR>

"let g:yankring_window_use_horiz = 0  " Use vertical split
"let g:yankring_window_width = 50
let g:yankring_window_height = 20
if using_neovim
    let g:yankring_history_dir = '~/.config/nvim/'
    " Fix for yankring and neovim problem when system has non-text things
    " copied in clipboard
    let g:yankring_clipboard_monitor = 0
else
    let g:yankring_history_dir = '~/.vim/dirs/'
endif


" Ack.vim ------------------------------

let g:ackhighlight = 1
let g:ack_autofold_results = 1

" mappings
nmap ,r :Ack! 
nmap ,wr :execute ":Ack! " . expand('<cword>')<CR>


" Window Chooser ------------------------------

" mapping
nmap  -  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1


" Autoclose ------------------------------

" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert
"  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}


" Deoplete -----------------------------

" Use deoplete.
let g:deoplete#enable_at_startup = 1
"call deoplete#custom#option({
"\   'ignore_case': v:true,
"\   'smart_case': v:true,
"\   'auto_complete_delay': 10,
"\})
" complete with words from any opened file
"let g:context_filetype#same_filetypes = {}
"let g:context_filetype#same_filetypes._ = '_'


" Jedi-vim ------------------------------

" Disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0

" All these mappings work only for python code:
" Go to definition
let g:jedi#goto_command = ',d'
" Find ocurrences
let g:jedi#usages_command = ',o'
" Find assignments
let g:jedi#goto_assignments_command = ',a'
" Go to definition in new tab
nmap ,D :tab split<CR>:call jedi#goto()<CR>


" Syntastic ------------------------------

" show list of errors and warnings on the current file
"nmap <leader>e :Errors<CR>
"" check also when just opened the file
"let g:syntastic_check_on_open = 1
"" don't put icons on the sign column (it hides the vcs status icons of signify)
"let g:syntastic_enable_signs = 0
" custom icons (enable them if you use a patched font, and enable the previous 
" setting)
"let g:syntastic_error_symbol = '✗'
"let g:syntastic_warning_symbol = '⚠'
"let g:syntastic_style_error_symbol = '✗'
"let g:syntastic_style_warning_symbol = '⚠'


" Signify ------------------------------

" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = ['git']
set updatetime=100

" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)

" nicer colors
highlight SignColumn        cterm=NONE ctermbg=NONE guibg=NONE gui=NONE
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119 guifg=#00ff00
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167 guifg=#ff0000
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227 guifg=#ffff00
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119 guifg=#00ff00
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167 guifg=#ff0000
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227 guifg=#ffff00


" Google translation
let g:trans_default_direction = "es:en"
let g:trans_bin = "~/.vim"
inoremap <silent> <leader>t <ESC>:Trans<CR>


" Pytest
let g:pytest_executable = "py.test-3"
nmap <silent><Leader>f <Esc>:Pytest file<CR>
nmap <silent><Leader>c <Esc>:Pytest class<CR>
nmap <silent><Leader>m <Esc>:Pytest method<CR>


" Neomake ------------------------------

" Run linter on write
autocmd! BufWritePost * Neomake

" Check code as python3 by default
let g:neomake_python_python_maker = neomake#makers#ft#python#python()
"let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()
"let g:neomake_python_python_maker.exe = 'python3 -m py_compile'
"let g:neomake_python_flake8_maker.exe = 'python3 -m flake8'

let g:neomake_python_enabled_makers = ["pycodestyle", "flake8", "pylint"]

" Move pylint configuration to .pylintrc file
"let g:neomake_python_pylint_maker = {
    "\ 'args': ['--disable=invalid-name',
               "\ "--extension-pkg-whitelist=PyQt5"], 
    "\ }
"
"pycodestyle configuration
"Ignore several unnecessary warnings
"E116: unexpected indentation in comment
"W503: Line break occurred before a binary operator, deprecated   
"E226: Whitespace around arithmetic operator, annoying for long formulae 
"E741: Ambiguous variable name

let g:neomake_python_pycodestyle_maker = {
    \ 'args': ['--ignore=E116, W503, E226, E741'],
    \ }
let g:neomake_python_flake8_maker = {
    \ 'args': ['--ignore=E116, W503, E226, E741'],
    \ }

" Disable error messages inside the buffer, next to the problematic line
let g:neomake_virtualtext_current_error = 0
"let g:neomake_list_height = 2

" When reading a buffer (after 1s), and with no delay when work with battery
function! MyOnBattery()
  return readfile('/sys/class/power_supply/ADP1/online') == ['0']
endfunction
if MyOnBattery()
  call neomake#configure#automake('rw')
else
  call neomake#configure#automake('nrw', 1000)
endif


" Isort
"let g:vim_isort_map = '<Leader>g'
nmap <silent><Leader>i <Esc>:Isort<CR>


" ============================================================================
" Vim settings and mappings
" You can edit them as you wish
 

" needed so deoplete can auto select the first suggestion
set completeopt+=noinsert
" comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" disabled by default because preview makes the window flicker
set completeopt-=preview

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" save as sudo
ca w!! w !sudo tee "%"

" tab navigation mappings
map tt :tabnew 
map <M-Right> :tabn<CR>
imap <M-Right> <ESC>:tabn<CR>
map <M-Left> :tabp<CR>
imap <M-Left> <ESC>:tabp<CR>

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" clear search results
nnoremap <silent> // :noh<CR>

" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e

" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
set shell=/bin/bash 

" Ability to add python breakpoints
" (I use ipdb, but you can change it to whatever tool you use for debugging)
au FileType python map <silent> <leader>b Oimport ipdb<CR>ipdb.set_trace()<esc>
"au FileType python map <silent> <leader>b Obreakpoint()<esc>

" map space to add space
nnoremap  <space> i<space><ESC> 

" Mark long lines 
set colorcolumn=80
augroup longLines
    autocmd! BufEnter *.py,.vimrc,*.sh,*.c* :match ColorColumn /\%>80v.\+/
augroup END

" Configure the line wrap
set nowrap
set sidescroll=5
set listchars+=precedes:<,extends:>

" Include user's custom nvim configurations
if using_neovim
    let custom_configs_path = "~/.config/nvim/custom.vim"
else
    let custom_configs_path = "~/.vim/custom.vim"
endif
if filereadable(expand(custom_configs_path))
  execute "source " . custom_configs_path
endif

" Hide menu and toolbar and create shortcut to show/hide 
set go-=m
nnoremap <C-F2> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
set go-=T
nnoremap <C-F3> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>

" Define font
set guifont=DejaVu\ Sans\ Mono\ Book\ 10

" Set python3 as version for python mode run
" my vim version has python3 disabled
"let g:pymode_python = 'python3'

" Session configuration from Vim Hacking book
" Remember buffer cursor placement and folds
" set viewdir=$HOME/.vim/views/
" autocmd BufWinLeave * mkview
" autocmd BufWinEnter * silent loadview

set sessionoptions-=options
set sessionoptions-=buffers
set sessionoptions+=globals
set sessionoptions+=localoptions

" Load and save last session
autocmd VimEnter * call LoadSession()
autocmd VimLeave * call SaveSession()
function! SaveSession()
    execute 'NERDTreeClose'    
    execute 'mksession! $HOME/.vim/sessions/session.vim'
endfunction
function! LoadSession()
    if argc() == 0
        execute 'source $HOME/.vim/sessions/session.vim'
    endif
endfunction

" Define root directory
cd /home/jjgomera/Programacion/pychemqt

" Add folder to pythonpath 
:let $PYTHONPATH=$PYTHONPATH.":/home/jjgomera/Programacion/pychemqt"
:let $PYTHONPATH=$PYTHONPATH.":/home/jjgomera/Programacion/iapws"
:let $PYTHONPATH=$PYTHONPATH.":/usr/local/lib/python3.9/dist-packages/"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""" RUN CURRENT FILE """""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Execute current file
nnoremap <F5> :call ExecuteFile()<CR>

" Will attempt to execute the current file based on the `&filetype`
" You need to manually map the filetypes you use most commonly to the
" correct shell command.
function! ExecuteFile()
  let filetype_to_command = {
  \   'javascript': 'node',
  \   'coffee': 'coffee',
  \   'python': 'python3',
  \   'html': 'open',
  \   'sh': 'sh'
  \ }
  let cmd = get(filetype_to_command, &filetype, &filetype)
  call RunShellCommand(cmd." %s")
endfunction

" Enter any shell command and have the output appear in a new buffer
" For example, to word count the current file:
"
"   :Shell wc %s
"
" Thanks to: http://vim.wikia.com/wiki/Display_output_of_shell_commands_in_new_window
command! -complete=shellcmd -nargs=+ Shell call RunShellCommand(<q-args>)
function! RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction
