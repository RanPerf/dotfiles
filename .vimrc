
set nocompatible              " be iMproved, required
filetype off                  " required

set ttimeoutlen=10
set ts=4 sw=4
set splitright
set number
set signcolumn=number

set mouse=a

set splitbelow

let mapleader = "`"

call plug#begin()
"Plug 'Shougo/deoplete.nvim'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'lighttiger2505/deoplete-vim-lsp'
Plug 'crusoexia/vim-monokai'
Plug 'morhetz/gruvbox'
"Plug 'jackguo380/vim-lsp-cxx-highlight'
"Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tomtom/tcomment_vim'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'tpope/vim-fugitive'
"Plug 'neovim/nvim-lspconfig'
"Plug 'nvim-treesitter/nvim-treesitter'
"Plug 'p00f/clangd_extensions.nvim'
"Plug 'lfv89/vim-interestingwords'
Plug 'bfrg/vim-cpp-modern'
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " Multi-cursor and selection
Plug 'Asheq/close-buffers.vim' " Easy buffer cleanup
Plug 'tmsvg/pear-tree'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Valloric/YouCompleteMe'
Plug 'epheien/termdbg'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
call plug#end()

set background=dark
autocmd vimenter * ++nested colorscheme gruvbox
"hi StatusLine ctermbg=green ctermfg=black
"hi StatusLineNC ctermfg=green
set cursorline

let g:VM_maps = {}
let g:VM_maps['Find Under'] = '<C-d>'
let g:VM_maps['Find Subword Under'] = '<C-d>'
let g:VM_maps['Undo'] = 'u'
let g:VM_maps['Redo'] = '<C-r>'
let g:VM_mouse_mappings = 1

"Mappings
"EV - edit vimrc
nnoremap ev :vert new $MYVIMRC<CR>
nnoremap sv :source $MYVIMRC<CR>

" mappings to go the beginning and the end of the line
nnoremap H 0
nnoremap L $

" move lines
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

" ease up window switching
nnoremap <M-right> <c-w>l
nnoremap <M-left> <c-w>h
nnoremap <M-down> <c-w>j
nnoremap <M-up> <c-w>k

nnoremap <C-S-Right> gt
nnoremap <C-S-Left> gT

tnoremap <Esc> <C-\><C-n>

" NERDTree

 " Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Open the existing NERDTree on each new tab.
"autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == 'bv' | NERDTreeMirror | endif
" autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

function! ToggleNerdTree()
  set eventignore=BufEnter
  NERDTreeTabsToggle
  set eventignore=
endfunction

nnoremap <Tab> :call ToggleNerdTree()<CR>

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

" fzf integration
nnoremap <c-p> :Files ./<cr>
nnoremap <c-f> :Ag<cr>
let g:fzf_buffers_jump = 1
function! s:GotoOrOpen(command, ...)
	for file in a:000
		if a:comman/d == 'e'
			exec 'e ' . file
		else
			exec "tab drop " . file
		endif
	endfor
endfunction
command! -nargs=+ GotoOrOpen call s:GotoOrOpen(<f-args>)
let g:fzf_action = {
  \ 'ctrl-t': 'GotoOrOpen tab',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" close-buffers
" Invoke menu to close buffers
nnoremap <silent> <C-q> :Bdelete menu<CR>

" Duplicate current line down
nnoremap <C-S-down> yyp


" pear-tree
let g:pear_tree_repeatable_expand = 0

inoremap jk <esc>

" Visual bindings
vnoremap <C-C> :w !xclip -i -sel c<CR><CR>

" fix Make command
set makeprg=ninja\ -C\ build

" YouCompleteMe

let g:ycm_enable_semantic_highlighting=1

set completeopt-=preview

nnoremap jt :YcmCompleter GoTo<CR>
nnoremap ji :YcmCompleter GoToInclude<CR>
nnoremap jf :YcmCompleter GoToDefinition<CR>
nnoremap jc :YcmCompleter GoToDeclaration<CR>
nnoremap jr :YcmCompleter GoToReferences<CR>
nnoremap jo :YcmCompleter GoToDocumentOutline<CR>
nnoremap fix :YcmCompleter FixIt<CR>

" gdb integration

nnoremap tpl :packadd termdebug<CR>  

nnoremap tb :Break<CR>  
nnoremap tn :Over<CR>
nnoremap tf :Finish<CR>
nnoremap tl :TLocateCursor<CR>
nnoremap ts :Step<CR>
