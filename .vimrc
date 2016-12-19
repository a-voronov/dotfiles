" Environment {
    " Basics {
        set nocompatible                " Must be first line
    " }
" }

" Use before config if available {
    if filereadable(expand("~/.vimrc.before"))
        source ~/.vimrc.before
    endif
" }

" Use bundles config {
    if filereadable(expand("~/.vimrc.bundles"))
        source ~/.vimrc.bundles
    endif
" }

" General {
    set background=dark                 " Assume a dark background
    filetype plugin indent on           " Automatically detect filetype
    syntax on                           " Syntax highlighting
    set mouse=a                         " Automatically enable mouse usage
    set mousehide                       " Hide the mouse cursor while typing
    scriptencoding utf-8
    set textwidth=100
    " set autowrite                     " Automatically write a file when leaving a modified buffer
    set history=1000                    " Store a ton of history (default is 20)
    set spell                           " Spell checking on
    runtime macros/matchit.vim          " Jump between tags with '%'

"     set ttyfast                         " u got a fast terminal
"     set ttyscroll=999
"     set lazyredraw                      " to avoid scrolling problems

    set clipboard=unnamed              " synchronize Vim's default register and the clipboard register

    " No annoying sound on errors
    set noerrorbells
    set vb t_vb=

    " Setting up the directories {
        set nobackup                      " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif
    " }

    " Fuzzy file search plugin for quick browsing of a project
    map <silent> <leader><space> :CtrlP()<CR>

    augroup sourcing
      autocmd!
      if has('nvim')
        autocmd bufwritepost init.vim source $MYVIMRC
      else
        autocmd bufwritepost .vimrc source $MYVIMRC
      endif
    augroup END

    " Return to last edit position when opening files (You want this!)
    augroup last_edit
      autocmd!
      autocmd BufReadPost *
           \ if line("'\"") > 0 && line("'\"") <= line("$") |
           \   exe "normal! g`\"" |
           \ endif
    augroup END
    " Remember info about open buffers on close
    set viminfo^=%
" }

" Vim UI {
    let g:solarized_termcolors=1        " Put 1 to run in Terminal.app Solarized Color Scheme, and 256 for Custom Scheme
    let g:solarized_termtrans = 1
    let g:solarized_visibility="normal"
    let g:solarized_contrast="normal"
    colorscheme solarized

    set colorcolumn=120                 " set a vertical line for long line width
    set tabpagemax=15                   " only show 15 tabs
    set showmode                        " display the current mode
    set cursorline                      " highlight current line
    highlight CursorLine ctermbg=none   " highlight only number on current line
    set noruler                         " don't show the ruler
    " set relativenumber
    set number

    set backspace=indent,eol,start      " Backspace for dummies
    set linespace=0                     " No extra spaces between rows
    set showmatch                       " Show matching brackets/parenthesis
    set incsearch                       " Find as you type search
    set hlsearch                        " Highlight search terms
    set winminheight=0                  " Windows can be 0 line high
    set ignorecase                      " Case insensitive search
    set smartcase                       " Case sensitive when uc present
    set wildmenu                        " Show list instead of just completing
    set wildmode=list:longest,full      " Command <Tab> completion, list matches, then longest com
    set whichwrap=b,s,h,l,<,>,[,]       " Backspace and cursor keys wrap too
    " set scrolljump=5                  " Lines to scroll when cursor leaves screen
    " set scrolloff=3                   " Minimum lines to keep above and below cursor
    set list                            " Shoe trailing whitespaces
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

    " code folding settings
    " set foldmethod=manual             " fold based on indent
    " set foldnestmax=10                " deepest fold is 10 levels
    set nofoldenable                    " don't fold by default
    " set foldlevel=1

    " Statusline
    set laststatus=2
" }

" Formatting {
    set textwidth=0 wrapmargin=0
    set nowrap                          " Do not wrap long lines
    set autoindent                      " Indent at the same level of the previous line
    set shiftwidth=4                    " Use indents of 4 spaces
    set tabstop=4                       " An indentation every four columns
    set expandtab                       " Tabs are spaces, not tabs
    set smarttab                        " Be smart when using tabs :)
    set softtabstop=4                   " Let backspace delete indent
    set pastetoggle=<F12>               " pastetoggle (sane indentation on pastes)

    autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2

    " Common Tabularizations {
        nmap <leader>a= :Tabularize /=<CR>
        vmap <leader>a= :Tabularize /=<CR>
        nmap <leader>a<bar> :Tabularize /<bar><CR>
        vmap <leader>a<bar> :Tabularize /<bar><CR>
        nmap <leader>a, :Tabularize /,<CR>
        vmap <leader>a, :Tabularize /,<CR>
        nmap <leader>ap :Tabularize
        vmap <leader>ap :Tabularize
    " }
" }

" Key (re)Mapping {
    " The default leader is '\', but many people prefer ',' as it's in a standard location.

    let mapleader = ','
" }

" Fonts {
    " Apply powerline fonts
    let g:airline_powerline_fonts = 1
    if has("gui_running")
        let s:uname = system("uname")
        set guifont=Meslo\ LG\ S\ Regular\ for\ Powerline:h11
    endif
" }

" Plugins {
    " Markdown Preview {
        " let vim_markdown_preview_github=1         " Not using grip until offline tool is finished, since it requires Github auth
        let vim_markdown_preview_toggle=2           " Generate Markdown preview on buffer write and display images automatically
        let vim_markdown_preview_browser='Safari'   " Use Safari as default preview browser
    " }

    " Gigutter {
        " disabling all key mappings not to mess with ghcmod keys
        let g:gitgutter_map_keys = 0
    " }

    " NERDTree {
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
        map <C-e> :NERDTreeToggle<CR>

        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=1
        let NERDTreeMouseMode=2
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
        let g:nerdtree_tabs_open_on_gui_startup=0
    " }

    " Haskell {
        " Configure browser for haskell_doc.vim
        let g:haddock_browser = "open"
        let g:haddock_browser_callformat = "%s %s"

        " Syntax, Completion, Lint & Refactor {
            " Workaround vim-commentary for Haskell
            autocmd FileType haskell setlocal commentstring=--\ %s
            " Workaround broken color highlighting in Haskell
            autocmd FileType haskell setlocal nospell

            let g:syntastic_haskell_checkers = ['hlint', 'ghc_mod']

            " Disable hlint-refactor-vim's default keybindings
            let g:hlintRefactor#disableDefaultKeybindings = 1

            " hlint-refactor-vim keybindings
            map <silent> <leader>hr :call ApplyOneSuggestion()<CR>
            map <silent> <leader>hR :call ApplyAllSuggestions()<CR>

            " Show types in completion suggestions
            let g:necoghc_enable_detailed_browse = 1

            " Provide (neco-ghc) omnicompletion
            if has("gui_running")
              imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
            else " no gui
              if has("unix")
                inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
              endif
            endif

            " Haskell Lint
            nmap <silent> <leader>hl :Neomake hlint<CR>

            " Options for Haskell Syntax Check
            let g:neomake_haskell_ghc_mod_args = '-g-Wall'

            " Fix path issues from vim.wikia.com/wiki/Set_working_directory_to_the_current_file
            let s:default_path = escape(&path, '\ ') " store default value of 'path'
            " Always add the current file's directory to the path and tags list if not
            " already there. Add it to the beginning to speed up searches.
            autocmd BufRead *
                  \ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
                  \ exec "set path-=".s:tempPath |
                  \ exec "set path-=".s:default_path |
                  \ exec "set path^=".s:tempPath |
                  \ exec "set path^=".s:default_path
        " }

        " GHC-Mod {
            " Resolve ghcmod base directory
            au FileType haskell let g:ghcmod_use_basedir = getcwd()

            " Type of expression under cursor
            nmap <silent> <leader>ht :GhcModType<CR>
            " Insert type of expression under cursor
            nmap <silent> <leader>hT :GhcModTypeInsert<CR>
            " Expand cases
            nmap <silent> <leader>hc :GhcModSplitFunCase<CR>
            " Clear expression type selection
            nmap <silent> <leader><CR> :GhcModTypeClear<CR>

            " GHC errors and warnings
            nmap <silent> <leader>hm :Neomake ghcmod<CR>

            " open the neomake error window automatically when an error is found
            let g:neomake_open_list = 2
        " }

        " Hoogle {
            " Hoogle the word under the cursor
            nnoremap <silent> <leader>hh :Hoogle<CR>

            " Hoogle and prompt for input
            nnoremap <leader>hH :Hoogle

            " Hoogle for detailed documentation (e.g. "Functor")
            nnoremap <silent> <leader>hi :HoogleInfo<CR>

            " Hoogle for detailed documentation and prompt for input
            nnoremap <leader>hI :HoogleInfo

            " Hoogle, close the Hoogle window
            nnoremap <silent> <leader>hz :HoogleClose<CR>
        " }

        " Tags {
            map <leader>tt :TagbarToggle<CR>

            set tags=tags;/
            set cst
            set csverb

            set tags+=codex.tags;/

            let g:tagbar_type_haskell = {
                \ 'ctagsbin'  : 'hasktags',
                \ 'ctagsargs' : '-x -c -o-',
                \ 'kinds'     : [
                    \  'm:modules:0:1',
                    \  'd:data: 0:1',
                    \  'd_gadt: data gadt:0:1',
                    \  't:type names:0:1',
                    \  'nt:new types:0:1',
                    \  'c:classes:0:1',
                    \  'cons:constructors:1:1',
                    \  'c_gadt:constructor gadt:1:1',
                    \  'c_a:constructor accessors:1:1',
                    \  'ft:function types:1:1',
                    \  'fi:function implementations:0:1',
                    \  'o:others:0:1'
                \ ],
                \ 'sro'        : '.',
                \ 'kind2scope' : {
                    \ 'm' : 'module',
                    \ 'c' : 'class',
                    \ 'd' : 'data',
                    \ 't' : 'type'
                \ },
                \ 'scope2kind' : {
                    \ 'module' : 'm',
                    \ 'class'  : 'c',
                    \ 'data'   : 'd',
                    \ 'type'   : 't'
                \ }
            \ }

            " Generate haskell tags with codex and hscope
            map <leader>tg :!codex update --force<CR>:call system("git-hscope -X TemplateHaskell")<CR><CR>:call LoadHscope()<CR>

            set csprg=hscope
            set csto=1 " search codex tags first

            nnoremap <silent> <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>
            " Automatically make cscope connections
            function! LoadHscope()
              let db = findfile("hscope.out", ".;")
              if (!empty(db))
                let path = strpart(db, 0, match(db, "/hscope.out$"))
                set nocscopeverbose " suppress 'duplicate connection' error
                exe "cs add " . db . " " . path
                set cscopeverbose
              endif
            endfunction
            au BufEnter /*.hs call LoadHscope()
        " }
    " }

    " Swift {
        let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']
    " }

    " neocomplete {
        " Disable AutoComplPop.
        let g:acp_enableAtStartup = 0
        " Use neocomplete.
        let g:neocomplete#enable_at_startup = 1
        " Use smartcase.
        let g:neocomplete#enable_smart_case = 1
        " Set minimum syntax keyword length.
        let g:neocomplete#sources#syntax#min_keyword_length = 3
        let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

        " Define dictionary.
        let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

        " Define keyword.
        if !exists('g:neocomplete#keyword_patterns')
            let g:neocomplete#keyword_patterns = {}
        endif
        let g:neocomplete#keyword_patterns['default'] = '\h\w*'

        " Plugin key-mappings.
        inoremap <expr><C-g>     neocomplete#undo_completion()
        inoremap <expr><C-l>     neocomplete#complete_common_string()

        " Recommended key-mappings.
        " <CR>: close popup and save indent.
        inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
        function! s:my_cr_function()
            return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
            " For no inserting <CR> key.
            "return pumvisible() ? "\<C-y>" : "\<CR>"
        endfunction
        " <TAB>: completion.
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

        " Enable omni completion
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
        autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
    " }

    " neosnippet {
        " call vam#ActivateAddons(['neosnippet', 'neosnippet-snippets'])
        " Plugin key-mappings.
        imap <C-k>     <Plug>(neosnippet_expand_or_jump)
        smap <C-k>     <Plug>(neosnippet_expand_or_jump)
        xmap <C-k>     <Plug>(neosnippet_expand_target)

        " SuperTab like snippets behavior.
        "imap <expr><TAB>
        " \ pumvisible() ? "\<C-n>" :
        " \ neosnippet#expandable_or_jumpable() ?
        " \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
        smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
    "}

    " syntastic {
        let g:syntastic_always_populate_loc_list = 1
        let g:syntastic_auto_loc_list = 1
        let g:syntastic_check_on_open = 1
        let g:syntastic_check_on_wq = 1
    " }
" }

