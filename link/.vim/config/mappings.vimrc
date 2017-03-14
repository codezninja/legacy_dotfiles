" Change mapleader
let mapleader=","

" Now ; works just like : but with 866% less keypresses!
nnoremap ; :

" Move more naturally up/down when wrapping is enabled.
nnoremap j gj
nnoremap k gk

nnoremap <leader>w :<C-u>Kwbd<cr>

" Clear last search
map <silent> <leader>/ <Esc>:nohlsearch<CR>

" Ctrl-J/K/L/H select split
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

" Buffer navigation
nnoremap <leader>b :CtrlPBuffer<CR> " List other buffers
map <leader><leader> :b#<CR> " Switch between the last two files
map gb :bnext<CR> " Next buffer
map gB :bprev<CR> " Prev buffer

" Jump to buffer number 1-9 with ,<N> or 1-99 with <N>gb
let c = 1
while c <= 99
  if c < 10
    execute "nnoremap <silent> <leader>" . c . " :" . c . "b<CR>"
  endif
  execute "nnoremap <silent> " . c . "gb :" . c . "b<CR>"
  let c += 1
endwhile

" Trim extra whitespace (,ss)
function! StripExtraWhiteSpace()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction
noremap <leader>ss :call StripExtraWhiteSpace()<CR>

" Fix page up and down
map <PageUp> <C-U>
map <PageDown> <C-D>
imap <PageUp> <C-O><C-U>
imap <PageDown> <C-O><C-D>

" Use Q for formatting the current paragraph (or selection)
" vmap Q gq
" nmap Q gqap

" F12: Source .vimrc & .gvimrc files
nmap <F12> :call SourceConfigs()<CR>

if !exists("*SourceConfigs")
  function! SourceConfigs()
    let files = ".vimrc"
    source $MYVIMRC
    if has("gui_running")
      let files .= ", .gvimrc"
      source $MYGVIMRC
    endif
    echom "Sourced " . files
  endfunction
endif

" CtrlP
map <leader>p <C-P>
map <leader>r :CtrlPMRUFiles<CR>

" NERDTree
map <leader>n :NERDTreeToggle<CR>

" eclim
augroup eclim
  autocmd!

  " Debug command for Spring Boot projects
  autocmd FileType java command! Debug bd | ! mvn clean package -DskipTests && mvim --servername mvim && java -Xdebug -Xrunjdwp:server=y,transport=dt_socket,address=1044,suspend=n -jar ./target/*-null.war

  " Shortcuts
  autocmd FileType java nnoremap <leader>jo :JavaImportOrganize<CR>
  autocmd FileType java nnoremap <leader>jdb :JavaDebugStart localhost 1044<CR>

  autocmd FileType java nnoremap <leader>jb :JavaDebugBreakpointToggle<CR>
  autocmd FileType java nnoremap <leader>jl :JavaDebugBreakpointsList<CR>

  autocmd FileType java nnoremap <leader>o :call eclim#java#debug#Step("over") <bar> JavaDebugStatus<CR>
  autocmd FileType java nnoremap <leader>i :call eclim#java#debug#Step("into") <bar> JavaDebugStatus<CR>
  autocmd FileType java nnoremap <leader>c :call eclim#java#debug#Step("return") <bar> JavaDebugStatus<CR>

augroup end


