" Copy to OS clipboard
set clipboard=unnamed
set pastetoggle=<F10>

" Local dirs
set backupdir=$DOTFILES/caches/vim
set directory=$DOTFILES/caches/vim
set undodir=$DOTFILES/caches/vim
let g:netrw_home = expand('$DOTFILES/caches/vim')

" Indentation
set autoindent " Copy indent from last line when starting new line.
set expandtab " Expand tabs to spaces
set shiftwidth=2 " The # of spaces for indenting.
set tabstop=2 " Tabs indent only 2 spaces
set softtabstop=2 " Tab key results in 2 spaces
set smarttab " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces.

" Indentation for different file types
au BufNewFile,BufRead *.java
        \ set shiftwidth=4 |
        \ set tabstop=4 |
        \ set softtabstop=4 |
        \ set expandtab

" Reformatting
set nojoinspaces " Only insert single space after a '.', '?' and '!' with a join command.

" Trim extra whitespace (,ss)
function! StripExtraWhiteSpace()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction
noremap <leader>ss :call StripExtraWhiteSpace()<CR>

" Search / replace
set gdefault " By default add g flag to search/replace. Add g to toggle.
set hlsearch " Highlight searches
set incsearch " Highlight dynamically as pattern is typed.
set ignorecase " Ignore case of searches.
set smartcase " Ignore 'ignorecase' if search pattern contains uppercase characters.

" Ignore things
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/bower_components/*,*/node_modules/*
set wildignore+=*/vendor/*,*/.git/*,*/.hg/*,*/.svn/*,*/log/*,*/tmp/*

" Vim commands
set hidden " When a buffer is brought to foreground, remember undo history and marks.
set report=0 " Show all changes.
set mouse=a " Enable mouse in all modes.
set shortmess+=I " Hide intro menu.

" Splits
set splitbelow " New split goes below
set splitright " New split goes right

" When editing a file, always jump to the last known cursor position. Don't do
" it for commit messages, when the position is invalid, or when inside an event
" handler (happens when dropping a file on gvim).
augroup vimrcEx
  autocmd!
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" FILE TYPES
augroup file_types
  autocmd!

  " vim
  autocmd BufRead .vimrc,*.vim set keywordprg=:help

augroup END

let g:gitgutter_async=0
