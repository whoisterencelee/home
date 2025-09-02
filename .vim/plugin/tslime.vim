" Tslime.vim. Send portion of buffer to tmux instance
" Maintainer: C.Coutinho <kikijump [at] gmail [dot] com>
" Modified:   Added filetype-specific prefixes and suffixes

if exists("g:loaded_tslime") && g:loaded_tslime
  finish
endif

let g:loaded_tslime = 1

" Filetype-specific prefixes and suffixes for REPL environments
let g:tslime_filetype_prefixes = {
      \ 'javascript': '.editor',
      \ 'python':     '',
      \ 'ruby':       '',
      \ 'sh':         '',
      \ 'zsh':        '',
      \ 'bash':       '',
      \ 'lua':        '',
      \ 'vim':        '',
      \ 'sql':        '',
      \ 'rust':       '',
      \ 'go':         '',
      \ 'java':       '',
      \ 'c':          '',
      \ 'cpp':        '',
      \ 'php':        '',
      \ 'r':          '',
      \ 'haskell':    ':{\|',
      \ 'clojure':    '',
      \ 'elixir':     '',
      \ 'scala':      ':paste',
      \ 'julia':      '',
      \ }

let g:tslime_filetype_suffixes = {
      \ 'javascript': "\<C-d>",
      \ 'python':     "\<CR>",
      \ 'ruby':       "\<C-d>",
      \ 'sh':         "\<C-d>",
      \ 'zsh':        "\<C-d>",
      \ 'bash':       "\<C-d>",
      \ 'lua':        "\<C-d>",
      \ 'vim':        "\<CR>",
      \ 'sql':        ";\<CR>",
      \ 'rust':       "\<C-d>",
      \ 'go':         "\<C-d>",
      \ 'java':       "\<C-d>",
      \ 'c':          "\<C-d>",
      \ 'cpp':        "\<C-d>",
      \ 'php':        "\<C-d>",
      \ 'r':          "\<CR>",
      \ 'haskell':    "\<CR>:}\<CR>",
      \ 'clojure':    "\<CR>",
      \ 'elixir':     "\<C-c>\<C-c>",
      \ 'scala':      "\<C-d>",
      \ 'julia':      "\<C-d>",
      \ }

" Default prefix and suffix if filetype not found
let g:tslime_default_prefix = ''
let g:tslime_default_suffix = "\<CR>"

" Function to send keys to tmux
function! Send_keys_to_Tmux(keys)
  if !exists("g:tslime")
    call <SID>Tmux_Vars()
  endif

  call system("tmux set-buffer -b tslime_buffer " . shellescape(a:keys))
  call system("tmux paste-buffer -b tslime_buffer -t " . s:tmux_target() )
endfunction

" Main function.
function! Send_to_Tmux(text)
  call Send_keys_to_Tmux( a:text )
  "   call Send_keys_to_Tmux('"'.escape(a:text, '\"$`').'"')
endfunction

function! s:tmux_target()
  return '"' . g:tslime['session'] . '":' . g:tslime['window'] . "." . g:tslime['pane']
endfunction

function! AddPrefixSuffix(text)
  let ft = &filetype
  let prefix = get(g:tslime_filetype_prefixes, ft, g:tslime_default_prefix)
  let suffix = get(g:tslime_filetype_suffixes, ft, g:tslime_default_suffix)
  
  " For languages that need special handling
  if ft == 'haskell'
    " Haskell needs special multi-line handling
    let result = prefix . a:text . suffix
  elseif ft == 'scala'
    " Scala paste mode
    let result = prefix . "\n" . a:text . suffix
  elseif prefix != ''
    let result = prefix . "\n" . a:text . suffix
  else
    let result = a:text . suffix
  endif
  
  return result
endfunction

function! SendToTmux(text)
  let processed_text = AddPrefixSuffix(a:text)
  call Send_to_Tmux(processed_text)
endfunction

" Session completion
function! Tmux_Session_Names(A,L,P)
  return <SID>TmuxSessions()
endfunction

" Window completion
function! Tmux_Window_Names(A,L,P)
  return <SID>TmuxWindows()
endfunction

" Pane completion
function! Tmux_Pane_Numbers(A,L,P)
  return <SID>TmuxPanes()
endfunction

function! s:ActiveTarget()
  return split(system('tmux list-panes -F "active=#{pane_active} #{session_name},#{window_index},#{pane_index}" | grep "active=1" | cut -d " " -f 2 | tr , "\n"'), '\n')
endfunction

function! s:TmuxSessions()
  if exists("g:tslime_always_current_session") && g:tslime_always_current_session
    let sessions = <SID>ActiveTarget()[0:0]
  else
    let sessions = split(system("tmux list-sessions -F '#{session_name}'"), '\n')
  endif
  return sessions
endfunction

function! s:TmuxWindows()
  if exists("g:tslime_always_current_window") && g:tslime_always_current_window
    let windows = <SID>ActiveTarget()[1:1]
  else
    let windows = split(system('tmux list-windows -F "#{window_index}" -t ' . g:tslime['session']), '\n')
  endif
  return windows
endfunction

function! s:TmuxPanes()
  let all_panes = split(system('tmux list-panes -t "' . g:tslime['session'] . '":' . g:tslime['window'] . " -F '#{pane_index}'"), '\n')

  " If we're in the active session & window, filter away current pane from
  " possibilities
  let active = <SID>ActiveTarget()
  let current = [g:tslime['session'], g:tslime['window']]
  if active[0:1] == current
    call filter(all_panes, 'v:val != ' . active[2])
  endif
  return all_panes
endfunction

" set tslime.vim variables
function! s:Tmux_Vars()
  let names = s:TmuxSessions()
  let g:tslime = {}
  if len(names) == 1
    let g:tslime['session'] = names[0]
  else
    let g:tslime['session'] = ''
  endif
  while g:tslime['session'] == ''
    let g:tslime['session'] = input("session name: ", "", "customlist,Tmux_Session_Names")
  endwhile

  let windows = s:TmuxWindows()
  if len(windows) == 1
    let window = windows[0]
  else
    let window = input("window name: ", "", "customlist,Tmux_Window_Names")
    if window == ''
      let window = windows[0]
    endif
  endif

  let g:tslime['window'] =  substitute(window, ":.*$" , '', 'g')

  let panes = s:TmuxPanes()
  if len(panes) == 1
    let g:tslime['pane'] = panes[0]
  else
    let g:tslime['pane'] = input("pane number: ", "", "customlist,Tmux_Pane_Numbers")
    if g:tslime['pane'] == ''
      let g:tslime['pane'] = panes[0]
    endif
  endif
endfunction

vnoremap <silent> <Plug>SendSelectionToTmux "ry :call SendToTmux(@r)<CR>
nmap     <silent> <Plug>NormalModeSendToTmux vip <Plug>SendSelectionToTmux

nnoremap          <Plug>SetTmuxVars :call <SID>Tmux_Vars()<CR>

command! -nargs=* Tmux call Send_to_Tmux('<Args><CR>')

vmap <C-c><C-c> <Plug>SendSelectionToTmux
vmap <C-c>t "ry :echo Send_to_Tmux(@r)<CR>
nmap <C-c><C-c> <Plug>NormalModeSendToTmux
nmap <C-c>t vip "ry :echo Send_to_Tmux(@r)<CR>
nmap <C-c>s <Plug>SetTmuxVars
