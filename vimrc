set nocompatible
set noshowmode
set noruler
set laststatus=0
set number
set backspace=2
set shiftwidth=2


set termguicolors
set background=dark
" https://github.com/jsit/toast.vim
colorscheme toast

syntax on
filetype on
set hidden

let mapleader="!"

" Close all buffers on ZZ
nmap ZZ :xa!<CR>
nmap ZQ :qa!<CR>

" Tab/Window management
" Switch buffer
nnoremap <Leader>b :buffers<CR>:buffer<Space>
nnoremap <Leader>d :buffers<CR>:bdelete<Space>
" Split right/left
nnoremap <Leader>l :buffers<CR>:vert belowright sb<Space>
nnoremap <Leader>l :buffers<CR>:vert belowright sb<Space>
nnoremap <Leader>k :buffers<CR>:split<Space>
nnoremap <Leader>j :buffers<CR>:belowright split<Space>
" Move across tabs
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
" Delete window
nnoremap <c-q> <c-W>c

" Open File Tree
nnoremap <c-x> :call Tree()<CR>
function! Tree()
	if exists("t:NERDTree_is_open") && t:NERDTree_is_open
		NERDTreeClose
		let t:NERDTree_is_open = 0
	else
		NERDTreeToggle
		let t:NERDTree_is_open = 1
	endif
endfunction



" Saving File
noremap <silent> <Leader>w :update<CR>

noremap <leader>p :!man <cword><CR>


" Code Completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

" Perform dot command over visual block
vnoremap . :normal .<CR>

" Tabulation
map <C-t> <Insert><Space><Space><Space><Space>

" Autopairs shortcuts
let g:AutoPairsShortcutFastWrap = '<C-a>'
let g:AutoPairsShortcutJump = '<C-)>'

" Language Servers
" https://github.com/prabirshrestha/vim-lsp/tree/master
function! s:on_lsp_buffer_enabled() abort
	setlocal omnifunc=lsp#complete
	setlocal signcolumn=yes
	nmap <buffer> K <plug>(lsp-hover)
	nmap <buffer> <leader>x <plug>(lsp-document-format)
	nmap <buffer> gd <plug>(lsp-definition)
	nmap <buffer> <leader>a <plug>(lsp-code-action)
	nmap <buffer> <leader>r <plug>(lsp-rename)
	nmap <buffer> <leader>e <plug>(lsp-document-diagnostics)
	nmap <buffer> [ <plug>(lsp-previous-diagnostic)
	nmap <buffer> ] <plug>(lsp-next-diagnostic)
endfunction

augroup lsp_install
	au!
	autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END


" Plugin Management
call plug#begin()

" LSP
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

" Autocomplete
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Other
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'

call plug#end()


