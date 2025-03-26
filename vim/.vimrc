" Vundle installation
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
"" Insert Vundle plugins here

Plugin 'iamcco/markdown-preview.nvim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'prettier/vim-prettier'
Plugin 'fatih/vim-go'

"" End insert
call vundle#end()
" End Vundle installation
" -------------------------------


" General settings
filetype plugin indent on

" Tab behaviour
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent

" Visual settings
syntax enable
set number
set ruler
set cursorline
set t_Co=256
set gfn=Monospace\ 10

" Other settings
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

" Folding
set foldenable
set foldlevelstart=20
set foldmethod=indent
nnoremap <space> za

" Search options
set hlsearch
set incsearch
set ignorecase
set smartcase

" Fix backspace
set backspace=indent,eol,start


" Document specific settings
" Spellchecking
autocmd BufRead,BufNewFile *.md setlocal spell
set spelllang=en,sv

"" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='powerlineish' " 'deus'
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

"" vim-go
let g:go_def_mod='gopls'
let g:go_info_mode='gopls'
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_structs = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 1
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=2 shiftwidth=2 softtabstop=2

"" vim-terraform
let g:terraform_align=1
let g:terraform_binary_path="/usr/bin/tofu"
let g:terraform_fmt_on_save=1


"" Prettier
let g:prettier#exec_cmd_path = "/opt/homebrew/bin/prettier"
au BufWritePre *.js,*.ts,*.json,*.css execute "%!prettier --stdin-filepath %"


"" Markdown Preview
let g:mkdp_preview_options = {
      \ 'uml': { 'server': 'http://localhost:8080' }
      \ }


" QOL
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e
command! SortIPs :%sort n /.*\./ | %sort n /\.\d\+\./ | %sort n /\./ | %sort n

" Syntax highlighting syncing when starting
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

" Shortcuts, tab between bufferts
noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
