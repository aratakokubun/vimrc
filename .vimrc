" Release autogroup in MyAutoCmd
augroup MyAutoCmd
	autocmd!
augroup END

" vi 互換ではなくvimのデフォルト設定にする
set nocompatible
" 一旦ファイルタイプ関連を無効化
filetype off
" neobundleでプラグインを管理
if has('vim_starting')
		execute 'set runtimepath+=' . expand('~/.vim/bundle/neobundle.vim/')
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Installation check.
if neobundle#exists_not_installed_bundles()
		echomsg 'Not installed bundles : ' .
			\ string(neobundle#get_not_installed_bundle_names())
		echomsg 'Please execute ":NeoBundleInstall" command.'
endif

" 以下のプラグインをバンドル
NeoBundle 'git://github.com/kien/ctrlp.vim.git'
NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
NeoBundle 'git://github.com/scrooloose/nerdtree.git'
NeoBundle 'git://github.com/scrooloose/syntastic.git'
" 補完機能
" NeoBundle 'git://github.com/Shougo/neocomplcache.git'
"ファイラとして利用
NeoBundle 'git://github.com/Shougo/unite.vim.git'
" vim fugitive
NeoBundle 'git://github.com/tpope/vim-fugitive'
" java script 開発環境
NeoBundle 'marijnh/tern_for_vim'
" Vim filer
NeoBundle 'Shougo/vimfiler'
" Vim Proc
NeoBundle 'Shougo/vimproc'
" Vim shell
NeoBundle 'Shougo/vimshell'
" Hybrid Text
NeoBundle 'w0ng/vim-hybrid'
" QuickRun (神らしい)
NeoBundle 'thinca/vim-quickrun'
" QuickRun San値ピンチ
NeoBundle 'osyo-manga/quickrun-hook-santi_pinch'
" 検索結果を見やすくする
NeoBundle 'osyo-manga/vim-anzu'
" スニペット補完
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'

" ファイルタイプ関連を有効化
filetype on

" エンコード
set encoding=utf8
" ファイルエンコード
set fileencoding=utf-8
" バックスペースで消せるようにする
set backspace=indent,eol,start

" 表示設定
set number 		" 行番号を入れる
set title 		" 編集中のファイル名を表示
set shiftround 	" 
set showmatch 	" 括弧入力時の対応する括弧を表示
set matchtime=3 " ハイライト表示を3秒に設定
set infercase 	" 補完時に大文字小文字を区別しない
syntax on 		" コードの色分け
set tabstop=4 	" インデントをスペース4つ分に設定
set smartindent " 自動インデント
set backspace=indent,eol,start " バックスペースでなんでも消せるようにする
" クリップボードをデフォルトのレジスタとして指定
if has('unnamedplus')
		" set clipboard& clipboard+=unnamedplus " 2013/07/03 unnamed追加
		set clipboard& clipboard+=unnamedplus,unnamed
else
		" set clipboard& clipboard+=unnamed,autoselect " 2013/06/24 autoselect 削除
		set clipboard& clipboard+=unnamed
endif
" swap,backupファイルを無効にする
set nowritebackup
set nobackup
set noswapfile

" 色の設定
colorscheme delek
"colorscheme hybrid
"colorsheme jellybeans
" 背景を透過
highlight Normal ctermbg=none
set list " 不可視文字を可視化
set wrap " 長いテキストの折り返し

" snippet関連の設定
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" quickrunの設定
let g:quickrun_config ={}
let g:quickrun_config.R = {'command' : 'R -f %<cr>'}
" quickrun時のバッファの開き方の指定
" 一番下に水平分割してウィンドウを開く
" windowの高さは8行
let g:quickrun_config = {
\	"_" : {
\		"outputter/buffer/split" : ":botright 8sp",
\		"runner" : "vimproc",
\		"runner/vimproc/updatetime" : 40,
\		"hook/time/enable" : 1,
\	}
\}

" 検索関連
set hlsearch  	" 検索結果をハイライト表示
set ignorecase 	" 大文字今次を区別しない
set incsearch 	" インクリメンタルサーチ
set smartcase 	" 検索文字に大文字がある場合は大文字小文字を区別
" バックスラッシュやクエスチョンを状況に合わせて自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" ()等を打った括弧内に移動
inoremap "" ""<LEFT>
inoremap '' ''<LEFT>
inoremap () ()<LEFT>
inoremap {} {}<LEFT>
inoremap [] []<LEFT>
inoremap \|\| \|\|<LEFT>
vnoremap { "zdi{z}<LEFT>
vnoremap {" "zdi{"z"}<LEFT>
vnoremap {' "zdi{'z'}<LEFT>
vnoremap [ "zdi[z]<LEFT>
vnoremap [" "zdi["z"]<LEFT>
vnoremap [' "zdi['z']<LEFT>
vnoremap ( "zdi(z)<LEFT>
vnoremap (" "zdi("z")<LEFT>
vnoremap (' "zdi('z')<LEFT>
vnoremap " "zdi"z"<LEFT>
vnoremap ' "zdi'z''"<LEFT>

" 文頭文末への移動
inoremap <C-a> <HOME>
vnoremap <C-a> <HOME>
nnoremap <C-a> <HOME>
inoremap <C-e> <END>
vnoremap <C-e> <END>
nnoremap <C-e> <END>

" Endを打った時に改行
" inoremap end end<RETURN>

" snippetの展開
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" vimfiler起動時に自動的に分割状態にする
" autocmd VimEnter * VimFiler -split -simple -winwidth=25 -no-quit 
" let g:vimfiler_as_default_explorer=1
" let g:vimfiler_safe_mode_by_default=0
" let g:netrw_liststyle=3

" vimshell起動時に自動的に分割状態にする
"autocmd VimEnter * VimShell -split
:command! Vss :VimShellPop -split -winwidth=10

" 読み込み・作成したファイルが.txtの場合，syntaxをhybridにする
au BufRead,BufNewFile *.txt set syntax=hybrid

" Scriptがpythonの場合，Ctrl+Pでpythonのスクリプトとして実行
function! s:ExecPy()
	exe "!" . &ft . "%"
:endfunction
command! Exec call <SID>ExecPy()
autocmd FileType python map <silent> <C-P> :call <SID>ExecPy()<CR>

" pythonの辞書ファイルの場所を定義
autocmd FileType python let g:pydiction_location = '~/.vim/pydiction/complete-dict'

" jsのsyntastic highlight
" let g:syntastic_javascript_checker = "jshint"
