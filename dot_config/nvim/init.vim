" Some of these are taken from github.com/elenapan/dotfiles

" Get cool numbers on the side
set number relativenumber

" Use system clipboard
set clipboard=unnamedplus

" Let mouse do whatever it wants
set mouse=a

" Ignore case when searching until an actual case is inputted
set ignorecase smartcase

" Tab things. Make all indentation 4 spaces.
set smarttab
set expandtab
set tabstop=8
set softtabstop=4
set shiftwidth=4

" Keep cursor one line away from top and bottom edge
set scrolloff=1

" Keep cursor cursor 4 columns away from side edges
set sidescrolloff=4

" Show whitespaces. Doesn't work without set list
" Here's a tab: 		And a trailing space: 
set list
set listchars=tab:∣\ ›,trail:•

" Don't delete my commands, I'm thinking
set notimeout

" Add <> as a matching pair of brackets
set matchpairs+=<:>

" -- Remaps
" Clear search highlighting with Escape key
" nnoremap is used so that the inner <esc> isn't expanded
nnoremap <silent><esc> :noh<return><esc>

" Use ctrl with arrow keys to scroll :)
nmap <C-Up> <C-E>
nmap <C-Down> <C-Y>

vmap <C-Up> <C-E>
vmap <C-Down> <C-Y>

imap <C-Up> <esc><C-E>gi
imap <C-Down> <esc><C-Y>gi

" -- End remaps

" The following functions and remaps are from https://github/elenapan/dotfiles
" --------
" Make ci( work like quotes do
function! New_cib()
    if search("(","bn") == line(".")
        sil exe "normal! f)ci("
        sil exe "normal! l"
        startinsert
    else
        sil exe "normal! f(ci("
        sil exe "normal! l"
        startinsert
    endif
endfunction

" And for curly brackets
function! New_ciB()
    if search("{","bn") == line(".")
        sil exe "normal! f}ci{"
        sil exe "normal! l"
        startinsert
    else
        sil exe "normal! f{ci{"
        sil exe "normal! l"
        startinsert
    endif
endfunction

nnoremap ci( :call New_cib()<CR>
nnoremap cib :call New_cib()<CR>
nnoremap ci{ :call New_ciB()<CR>
nnoremap ciB :call New_ciB()<CR>

" Restore last cursor position and marks on open
au BufReadPost *
         \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' 
         \ |   exe "normal! g`\""
         \ | endif
" --------
