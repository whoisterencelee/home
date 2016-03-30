""remember to copy tmux into /usr/local/bin

function! EchoStatus(s)
  if !exists(g:EchoStatus")
    let g:EchoStatus = ""
  end
  let g:EchoStatus .= ">" . a:s
endfunction

function! MinifyJS(text)
  let cleantext = system("uglifyjs",a:text)
  call writefile([cleantext . ";\r" ],'/tmp/tslimebuffer','b')
  return cleantext
endfunction
  		
function! Send_to_Tmux(text)
  if !exists("b:tmux_sessionname") || !exists("b:tmux_windowname")
    if exists("g:tmux_sessionname") && exists("g:tmux_windowname")
      let b:tmux_sessionname = g:tmux_sessionname
      let b:tmux_windowname = g:tmux_windowname
      if exists("g:tmux_panenumber")
        let b:tmux_panenumber = g:tmux_panenumber
      end
    else
      call Tmux_Vars()
    end
  end

  let target = b:tmux_sessionname . ":" . b:tmux_windowname

  if exists("b:tmux_panenumber")
    let target .= "." . b:tmux_panenumber
  end

 "" let clean_text = substitute(a:text, "\n","","g")
  echo "Sending to tmux " . target

  ""call system("tmux set-buffer -t " . b:tmux_sessionname  . " '" . substitute(clean_text, "'", "'\\\\''", 'g') . ";\n'" )
  call system("tmux load-buffer /tmp/tslimebuffer")
  call system("tmux paste-buffer -r -t " . target)
endfunction

function! Tmux_Session_Names(A,L,P)
  return system("tmux list-sessions | sed -e 's/:.*$//'")
endfunction

function! Tmux_Window_Names(A,L,P)
  return system("tmux list-windows -t" . b:tmux_sessionname . ' | grep -e "^\w:" | sed -e "s/ \[[0-9x]*\]$//"')
endfunction

function! Tmux_Pane_Numbers(A,L,P)
  return system("tmux list-panes -t " . b:tmux_sessionname . ":" . b:tmux_windowname . " | sed -e 's/:.*$//'")
endfunction

function! Tmux_Vars()
  let b:tmux_sessionname = input("session name: ", "", "custom,Tmux_Session_Names")
  let b:tmux_windowname = substitute(input("window name: ", "", "custom,Tmux_Window_Names"), ":.*$" , '', 'g')

  if system("tmux list-panes -t " . b:tmux_sessionname . ":" . b:tmux_windowname . " | wc -l") > 1
    let b:tmux_panenumber = input("pane number: ", "", "custom,Tmux_Pane_Numbers")
  end

  if !exists("g:tmux_sessionname") || !exists("g:tmux_windowname")
    let g:tmux_sessionname = b:tmux_sessionname
    let g:tmux_windowname = b:tmux_windowname
    if exists("b:tmux_panenumber")
      let g:tmux_panenumber = b:tmux_panenumber
    end
  end
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

vmap <C-c><C-c> "ry :call Send_to_Tmux(MinifyJS(@r))<CR>
vmap <C-c>t "ry :echo MinifyJS(@r)<CR>

nmap <C-c><C-c> vip<C-c><C-c>
nmap <C-c>s :call Tmux_Vars()<CR>

