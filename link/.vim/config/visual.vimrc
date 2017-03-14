set number " Enable line numbers.
set showtabline=2 " Always show tab bar.
set relativenumber " Use relative line numbers. Current line is still in status bar.
set title " Show the filename in the window titlebar.
set nowrap " Do not wrap lines.
set noshowmode " Don't show the current mode (airline.vim takes care of us)
set laststatus=2 " Always show status line

" Show column 80, but don't autowrap
set textwidth=80
set colorcolumn=+1 " Highlight column
highlight ColorColumn ctermbg=236 guibg=#303030 " Highlight color
set formatoptions=cq " No autowrapping
set wrapmargin=0 " No wrapping based on terminal size

" Toggle between absolute and relative line numbers
augroup relative_numbers
  autocmd!
  " Show absolute numbers in insert mode
  autocmd InsertEnter * :set norelativenumber
  autocmd InsertLeave * :set relativenumber
augroup END

" Scrolling
set scrolloff=3 " Start scrolling three lines before horizontal border of window.
set sidescrolloff=3 " Start scrolling three columns before vertical border of window.

" Toggle show tabs and trailing spaces (,v)
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_,extends:>,precedes:<
"set fillchars=fold:-
nnoremap <silent> <leader>v :call ToggleInvisibles()<CR>

" Extra whitespace
augroup highlight_extra_whitespace
  autocmd!
  autocmd BufWinEnter * :2match ExtraWhitespaceMatch /\s\+$/
  autocmd InsertEnter * :2match ExtraWhitespaceMatch /\s\+\%#\@<!$/
  autocmd InsertLeave * :2match ExtraWhitespaceMatch /\s\+$/
augroup END

" Toggle Invisibles / Show extra whitespace
function! ToggleInvisibles()
  set nolist!
  if &list
    hi! link ExtraWhitespaceMatch ExtraWhitespace
  else
    hi! link ExtraWhitespaceMatch NONE
  endif
endfunction

set nolist
call ToggleInvisibles()

