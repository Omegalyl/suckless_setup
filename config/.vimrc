" Function to save, run Black, and reload the file
function! SaveFormatReload()
    " Save the file
    update
    " Run Black
    !black -l100 %
    " Reload the file
    edit
endfunction

" Mappings

let mapleader=" "
set clipboard=unnamedplus
set number
syntax on
set mouse=a

set hlsearch
nnoremap <leader><space> :nohlsearch<cr>

" Quickly open/source vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Auto-reload files when changed externally
set autoread
au FocusGained,BufEnter * :checktime

" python
nnoremap <leader>fp :call SaveFormatReload()<CR>
nnoremap <leader>rp :!python3 %<CR>

" Toggle spell checking
nnoremap <leader>s :setlocal spell!<cr>

" Easy window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Open new split panes to right and bottom
set splitbelow
set splitright

" Easier indentation of visual blocks
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

set clipboard=unnamedplus
" Copy yanked text to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y

" tab stop
set ts=4 sw=4

" C
nnoremap <leader>gc :w<CR>:!gcc % -o %:r && ./%:r<CR>
