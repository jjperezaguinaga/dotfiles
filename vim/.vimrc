" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2014 Feb 05
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

" Plugin Loading through vundle 
call vundle#begin()

" Nginx conf files highlightin
Plugin 'nginx.vim'

" Theme
Plugin 'altercation/vim-colors-solarized'

" Javascript (duh)
Plugin 'pangloss/vim-javascript'

" Typescript (duh)
Plugin 'leafgarland/typescript-vim'

" JSX Magic cause DOM is so 2015
Plugin 'mxw/vim-jsx'

" LESS (duh)
Plugin 'groenewege/vim-less'

" Search on stereoids
Plugin 'wincent/command-t'

" Syntax linting
Plugin 'scrooloose/syntastic'

" Use .editorconfig files in repos to avoid being “that” guy
Plugin 'editorconfig/editorconfig-vim'

" Git within vim
Plugin 'tpope/vim-fugitive'

call vundle#end()

" Set handlebars as html
autocmd BufNewFile,BufRead *.hbs  set syntax=html

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set clipboard=unnamed

" :vsplit makes everything al-right
set splitright


set tabstop=2
set shiftwidth=2
set expandtab

"see numbers
set relativenumber

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" Allow saving of files as sudo when I forgot to start vim using sudo."
 cmap w!! w !sudo tee > /dev/null %

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set backupdir=~/tmp
  set undofile		" keep an undo file (undo changes after closing)
  set undodir=~/tmp
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Switch between relative and number
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

" Change to absolute on focus lost
:au FocusLost * :set number
:au FocusGained * :set relativenumber

let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

" Typescript setup
let g:syntastic_typescript_checkers = ['tslint', 'tsc']
let g:syntastic_typescript_tsc_fname = ''
let g:syntastic_enable_signs=1     " enables error reporting in the gutter
let g:syntastic_auto_loc_list=1    " when there are errors, show the quickfix window that lists those errors

" Explorer mode for filetreeing
let g:netrw_liststyle=3

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

syntax enable
set background=dark
colorscheme solarized
