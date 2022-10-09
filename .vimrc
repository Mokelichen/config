syntax on
" tab宽度和缩进同样设置为4
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set backspace=2
set nocompatible
" 你在此设置运行时路径
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Vundle 本身就是一个插件
Plugin 'gmarik/Vundle.vim'
call vundle#end()
filetype off
filetype plugin indent on
" vim-go插件
Plugin 'fatih/vim-go'
" 鼠标右键粘贴
if has('mouse')
    set mouse-=a
endif

autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType java set omnifunc=javacomplete#Complete
autocmd FileType go set omnifunc=gocomplete#Complete

Plugin 'Tagbar'
" 设置tagbar的窗口宽度
let g:tagbar_width=30
" 映射Tagbar的快捷键,按F8自动打开
map <F8> :TagbarToggle<CR>

Plugin 'scrooloose/nerdtree'
map <F7> :NERDTreeToggle<CR>
