set nocompatible
set noshowmode
set noruler
set laststatus=0
set number
set backspace=2
set shiftwidth=2

set autoread

set termguicolors
set background=dark
" https://github.com/jsit/toast.vim
colorscheme toast

filetype on
set hidden

set undofile

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
nnoremap <Leader>h :buffers<CR>:vert belowleft sb<Space>
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
	"nmap <buffer> <leader>x <plug>(lsp-document-format)
	nmap <buffer> <silent> <leader>x :call <SID>format()<CR>
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

" LSP Diagnostics Configuration
let g:lsp_diagnostics_virtual_text_enabled = 0 
let g:lsp_diagnostics_highlights_enabled = 0

" Polyglot csv separator fix
let g:csv_no_conceal = 1

" Start preview
nmap <leader>m <Plug>MarkdownPreview
" Stop preview
nmap <leader>s <Plug>MarkdownPreviewStop

function! s:format() abort
	let l:save_cursor = getpos(".")
  if &filetype ==# 'markdown'
    silent execute '%!prettier --stdin-filepath ' . shellescape(expand('%:p'))
  else
    execute 'LspDocumentFormat'
  endif
	call setpos('.', l:save_cursor)
endfunction

" Define a custom function to open Brave in a new tab
function! OpenBraveInNewTab(url)
  let l:cmd = 'brave --new-window ' . shellescape(a:url)
  call system(l:cmd)
endfunction
" Disable default browser opening
let g:mkdp_browser = ''
let g:mkdp_browserfunc = 'OpenBraveInNewTab'

autocmd FileType markdown nnoremap <buffer> <C-b> o<br><CR><Esc>

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

" Markdown Preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install'  }


call plug#end()

syntax on
