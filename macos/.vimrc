"
" SETTING
"
"" Set the character code to UFT-8.
set fenc=utf-8
" Don't create backup files.
set nobackup
" Don't create swap files.
set noswapfile
" Automatically reread a file you are editing when it is changed.
set autoread
" Allow buffers to open other files while they are being edited.
set hidden
" Displays the status of the command being entered.
set showcmd
" Enable backspace in insert mode
set backspace=indent,eol,start

"
" APPEARANCE
"
" Display line numbers
set number
" Highlight the current line
set cursorline
" Highlight the current line (vertically)
set cursorcolumn
" The cursor can now be moved to one character ahead of the end of the line.
set virtualedit=onemore
" Indents are smart indents.
set smartindent
" Visualize the beep.
set visualbell
" Display the corresponding parentheses when entering parentheses.
set showmatch
" Always show the status line
set laststatus=2
" Command Line Completion
set wildmode=list:longest
" Enable to move the line in the display unit when wrapping.
nnoremap j gj
nnoremap k gk
" Enabling syntax highlighting.
syntax enable

"
" TAB
"
" Visualize invisible characters (Tab will be displayed as '▸-').
set list listchars=tab:\▸\-
" Set Tab characters to half-width spaces.
set expandtab
" Display width of Tab characters other than those at the beginning of a
" line (how many spaces).
set tabstop=2
" Display width of the Tab character at the beginning of a line
set shiftwidth=2

"
" SEARCH
"
" If the search string is lower case, the search is case-insensitive.
set ignorecase
" If a search string contains uppercase letters, it is searched separately.
set smartcase
" Sequentially hits the target string when entering a search string.
set incsearch
" Go back to the beginning when you reach the end of the search
set wrapscan
" Highlight the search term
set hlsearch
" Release the highlighting by pressing ESC.
nmap <Esc><Esc> :nohlsearch<CR><Esc>
