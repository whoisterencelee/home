# dependencies echo, expr, printf, whoami, hostname, date, df, sed, /proc/meminfo and /proc/loadavg, these are very based for POSIX systems should be available everywhere

# used ideas:
# use only 8 colours-black = 7, 31,32,33,34,35,36,37
# use \[\] to enclose non-printing characters e.g. \[\e[00;01\]white\[\e[m\] so it's not counted
# convert first letter to integer using printf "%u" "'string"
# escape single quote with 'abc'\''def'
# :<colon><prompt><semi-colon>; allow full line selection and ignore the prompt
# used black to hide characters \[\e[00;30m\]:\[\e[m\]\
# $((10+10)) to do integer calculation
# use only arthematic and loops to do percentage calculations, no floating point calculation

#2017-06-20 set based on $0 which is more stable than $SHELL
case $0 in
*/zsh|-zsh)
  prompt off
  PROMPT=\
$'\e[0;'$(expr $(printf "%u" "'$(whoami)") % 6 + 31)$'m%n \e[0m'\
$'\e[0;'$(expr $(printf "%u" "'$(hostname)") % 6 + 31)$'m%m \e[0m'\
"%{$fg[cyan]%}%D{%Y-%m-%d} %{$fg[green]%}%* "\
`load=\`sed "s/\([0-9]*\)[.]\([0-9]*\).*/1\1\2/" /proc/loadavg\`;if [[ $load -gt 1090 ]];then echo -n "%{$fg[red]%}LOAD>\`expr $load - 1000\`%% ";fi`\
`ramexp=\`sed -n "N;s/^MemTotal:[[:space:]]*\\([0-9]*\\) .*\\nMemFree:[[:space:]]*\\([0-9]*\\) .*/\\200 \\/ \\1/p" /proc/meminfo\`;ram=\`expr $ramexp\`;if [[ $ram -lt 10 ]];then echo -n "%{$fg[red]%}RAM<$ram%% ";fi`\
`disk=\`df . | sed -n "s/.* \([1-9]*[0-9]\)%.*/\1/p"\`;if [ $disk ];then if [[ $disk -gt 87 ]];then echo -n "%{$fg[red]%}DISK>$disk%%";fi;fi`\
"%{$fg[white]%}%~/ %{$reset_color%}"
 ;;
<<<<<<< HEAD
*/bash|-bash)
=======
*/bash)
  if command -v getprop >/dev/null 2>&1;then

  # tested in termux busybox
  export androidname=$(getprop net.hostname)
  export PS1='\
\[\e[00;`expr \`printf "%u" "'\''$(whoami)"\` % 6 + 31`m\]\u\[\e[m\]\
 \[\e[00;`expr \`printf "%u" "'\''$androidname"\` % 6 + 31`m\]$androidname\[\e[m\]\
 \[\e[00;36m\]`date +"%F\[\e[m\]\[\e[00;32m\] %T\[\e[m\]"`\
`load=\`sed "s/\([0-9]*\)[.]\([0-9]*\).*/1\1\2/" /proc/loadavg\`;if [[ $load -gt 1090 ]];then echo -n " \[\e[00;31m\]LOAD>\`expr $load - 1000\`%\[\e[m\]";fi`\
`ramexp=\`sed -rn "N;s/^MemTotal:[[:space:]]*([0-9]*) .*\\nMemFree:[[:space:]]*([0-9]*) .*/\\200 \\/ \\1/p" /proc/meminfo\`;ram=\`expr $ramexp\`;if [[ $ram -lt 10 ]];then echo -n " \[\e[00;31m\]RAM<$ram%\[\e[m\]";fi`\
`disk=\`df . | sed -n "s/.* \([1-9]*[0-9]\)%.*/\1/p"\`;if [ $disk ];then if [[ $disk -gt 87 ]];then echo -n " \[\e[00;31m\]DISK>$disk%\[\e[m\]";fi;fi`\
 \[\e[00;$(if [[ ! -w $PWD ]];then echo -n 31;fi)m\]\w/\[\e[m\]\
 '

  else

>>>>>>> refs/remotes/origin/master
  # tested in archlinux
  export PS1='\
\[\e[00;`expr \`printf "%u" "'\''$(whoami)"\` % 6 + 31`m\]\u\[\e[m\]\
 \[\e[00;`expr \`printf "%u" "'\''$(hostname)"\` % 6 + 31`m\]\h\[\e[m\]\
 \[\e[00;36m\]`date +"%F\[\e[m\]\[\e[00;32m\] %T\[\e[m\]"`\
`load=\`sed "s/\([0-9]*\)[.]\([0-9]*\).*/1\1\2/" /proc/loadavg\`;if [[ $load -gt 1090 ]];then echo -n " \[\e[00;31m\]LOAD>\`expr $load - 1000\`%\[\e[m\]";fi`\
<<<<<<< HEAD
`ramexp=\`sed -n "N;s/^MemTotal:[[:space:]]*\\([0-9]*\\) .*\\nMemFree:[[:space:]]*\\([0-9]*\\) .*/\\200 \\/ \\1/p" /proc/meminfo\`;ram=\`expr $ramexp\`;if [[ $ram -lt 10 ]];then echo -n " \[\e[00;31m\]RAM<$ram%\[\e[m\]";fi`\
=======
`ramexp=\`sed -rn "N;s/^MemTotal:[[:space:]]*([0-9]*) .*\\nMemFree:[[:space:]]*([0-9]*) .*/\\200 \\/ \\1/p" /proc/meminfo\`;ram=\`expr $ramexp\`;if [[ $ram -lt 10 ]];then echo -n " \[\e[00;31m\]RAM<$ram%\[\e[m\]";fi`\
>>>>>>> refs/remotes/origin/master
`disk=\`df . | sed -n "s/.* \([1-9]*[0-9]\)%.*/\1/p"\`;if [ $disk ];then if [[ $disk -gt 87 ]];then echo -n " \[\e[00;31m\]DISK>$disk%\[\e[m\]";fi;fi`\
 \[\e[00;$(if [[ ! -w $PWD ]];then echo -n 31;fi)m\]\w/\[\e[m\]\
 '

 fi
 ;;
<<<<<<< HEAD
*/ash|-ash)
  # testd in openwrt
=======
*/ash)
  # tested in openwrt
>>>>>>> refs/remotes/origin/master
  export PS1='\
\[\e[00;`expr \`printf "%u" "'\''$USER"\` % 6 + 31`m\]\u\[\e[m\]\
 \[\e[00;`expr \`printf "%u" "'\''$(hostid)"\` % 6 + 31`m\]\h\[\e[m\]\
 \[\e[00;36m\]`date +"%F\[\e[m\]\[\e[00;32m\] %T\[\e[m\]"`\
`load=\`sed "s/\([0-9]*\)[.]\([0-9]*\).*/1\1\2/" /proc/loadavg\`;if [[ $load -gt 1090 ]];then echo -n " \[\e[00;31m\]LOAD>\`expr $load - 1000\`%\[\e[m\]";fi`\
`ramexp=\`sed -rn "N;s/^MemTotal:[[:space:]]*([0-9]*) .*\\nMemFree:[[:space:]]*([0-9]*) .*/\\200 \\/ \\1/p" /proc/meminfo\`;ram=\`expr $ramexp\`;if [[ $ram -lt 10 ]];then echo -n " \[\e[00;31m\]RAM<$ram%\[\e[m\]";fi`\
`disk=\`df . | sed -n "s/.* \([1-9]*[0-9]\)%.*/\1/p"\`;if [ $disk ];then if [[ $disk -gt 87 ]];then echo -n " \[\e[00;31m\]DISK>$disk%\[\e[m\]";fi;fi`\
 \[\e[00;$(if [[ ! -w $PWD ]];then echo -n 31;fi)m\]\w/\[\e[m\]\
 '
 ;;
*)
  export PS1='>'
esac

#2016-12-07 set based on SHELL
#case $SHELL in
#*/zsh)
#  prompt off
#  PROMPT=\
#$'\e[0;'$(expr $(printf "%u" "'$(whoami)") % 6 + 31)$'m%n \e[0m'\
#$'\e[0;'$(expr $(printf "%u" "'$(hostname)") % 6 + 31)$'m%m \e[0m'\
#"%{$fg[cyan]%}%D{%Y-%m-%d} %{$fg[green]%}%* "\
#`load=\`sed "s/\([0-9]*\)[.]\([0-9]*\).*/1\1\2/" /proc/loadavg\`;if [[ $load -gt 1090 ]];then echo -n "%{$fg[red]%}LOAD>\`expr $load - 1000\`%% ";fi`\
#`ramexp=\`sed -n "N;s/^MemTotal:\\s*\\([0-9]*\\) .*\\nMemFree:\\s*\\([0-9]*\\) .*/\\200 \\/ \\1/p" /proc/meminfo\`;ram=\`expr $ramexp\`;if [[ $ram -lt 10 ]];then echo -n "%{$fg[red]%}RAM<$ram%% ";fi`\
#`disk=\`df . | sed -n "s/.* \([1-9]*[0-9]\)%.*/\1/p"\`;if [ $disk ];then if [[ $disk -gt 87 ]];then echo -n "%{$fg[red]%}DISK>$disk%%";fi;fi`\
#"%{$fg[white]%}%~/ %{$reset_color%}"
# ;;
#*/bash)
#  # tested in archlinux
#  export PS1='\
#\[\e[00;`expr \`printf "%u" "'\''$(whoami)"\` % 6 + 31`m\]\u\[\e[m\]\
# \[\e[00;`expr \`printf "%u" "'\''$(hostname)"\` % 6 + 31`m\]\h\[\e[m\]\
# \[\e[00;36m\]`date +"%F\[\e[m\]\[\e[00;32m\] %T\[\e[m\]"`\
#`load=\`sed "s/\([0-9]*\)[.]\([0-9]*\).*/1\1\2/" /proc/loadavg\`;if [[ $load -gt 1090 ]];then echo -n " \[\e[00;31m\]LOAD>\`expr $load - 1000\`%\[\e[m\]";fi`\
#`ramexp=\`sed -n "N;s/^MemTotal:\\s*\\([0-9]*\\) .*\\nMemFree:\\s*\\([0-9]*\\) .*/\\200 \\/ \\1/p" /proc/meminfo\`;ram=\`expr $ramexp\`;if [[ $ram -lt 10 ]];then echo -n " \[\e[00;31m\]RAM<$ram%\[\e[m\]";fi`\
#`disk=\`df . | sed -n "s/.* \([1-9]*[0-9]\)%.*/\1/p"\`;if [ $disk ];then if [[ $disk -gt 87 ]];then echo -n " \[\e[00;31m\]DISK>$disk%\[\e[m\]";fi;fi`\
# \[\e[00;$(if [[ ! -w $PWD ]];then echo -n 31;fi)m\]\w/\[\e[m\]\
# '
# ;;
#*/ash)
#  # testd in openwrt
#  export PS1='\
#\[\e[00;`expr \`printf "%u" "'\''$USER"\` % 6 + 31`m\]\u\[\e[m\]\
# \[\e[00;`expr \`printf "%u" "'\''$(hostid)"\` % 6 + 31`m\]\h\[\e[m\]\
# \[\e[00;36m\]`date +"%F\[\e[m\]\[\e[00;32m\] %T\[\e[m\]"`\
#`load=\`sed "s/\([0-9]*\)[.]\([0-9]*\).*/1\1\2/" /proc/loadavg\`;if [[ $load -gt 1090 ]];then echo -n " \[\e[00;31m\]LOAD>\`expr $load - 1000\`%\[\e[m\]";fi`\
#`ramexp=\`sed -rn "N;s/^MemTotal:[[:space:]]*([0-9]*) .*\\nMemFree:[[:space:]]*([0-9]*) .*/\\200 \\/ \\1/p" /proc/meminfo\`;ram=\`expr $ramexp\`;if [[ $ram -lt 10 ]];then echo -n " \[\e[00;31m\]RAM<$ram%\[\e[m\]";fi`\
#`disk=\`df . | sed -rn "s/.* \([1-9]*[0-9]\)%.*/\1/p"\`;if [ $disk ];then if [[ $disk -gt 87 ]];then echo -n " \[\e[00;31m\]DISK>$disk%\[\e[m\]";fi;fi`\
# \[\e[00;$(if [[ ! -w $PWD ]];then echo -n 31;fi)m\]\w/\[\e[m\]\
# '
# ;;
#esac


#2014-01-01 make ZSH compatible
#  PS1=\
#"%{$fg[cyan]%}%D{%Y-%m-%d} %{$fg[green]%}%* "\
#`load=\`sed "s/\([0-9]*\)[.]\([0-9]*\).*/1\1\2/" /proc/loadavg\`;if [[ $load -gt 1090 ]];then echo -n "%{$fg[red]%}LOAD>\`expr $load - 1000\`%% ";fi`\
#`ramexp=\`sed -n "N;s/^MemTotal:\\s*\\([0-9]*\\) .*\\nMemFree:\\s*\\([0-9]*\\) .*/\\200 \\/ \\1/p" /proc/meminfo\`;ram=\`expr $ramexp\`;if [[ $ram -lt 10 ]];then echo -n "%{$fg[red]%}RAM<$ram%% ";fi`\
#`disk=\`df . | sed -n "s/.* \([1-9]*[0-9]\)%.*/\1/p"\`;if [ $disk ];then if [[ $disk -gt 87 ]];then echo -n "%{$fg[red]%}DISK>$disk%%";fi;fi`\
#"%{$fg[white]%}%~/ %{$reset_color%}"

#2013-12-31 use single quote ` to execute statements as bash doesn't allow nested $($())
#2013-12-31 use expr instead of $[] or $(()) to be more backward compatible with sh
#2013-12-31 fixed bug with date escape sequence 
#export PS1='\
#\[\e[00;`expr \`printf "%u" "'\''$(whoami)"\` % 6 + 31`m\]\u\[\e[m\]\
# \[\e[00;`expr \`printf "%u" "'\''$(hostname)"\` % 6 + 31`m\]\h\[\e[m\]\
# \[\e[00;36m\]`date +"%F\[\e[m\]\[\e[00;32m\] %T\[\e[m\]"`\
#`load=\`sed "s/\([0-9]*\)[.]\([0-9]*\).*/1\1\2/" /proc/loadavg\`;if [[ $load -gt 1090 ]];then echo -n " \[\e[00;31m\]LOAD>\`expr $load - 1000\`%\[\e[m\]";fi`\
#`ramexp=\`sed -n "N;s/^MemTotal:\\s*\\([0-9]*\\) .*\\nMemFree:\\s*\\([0-9]*\\) .*/\\200 \\/ \\1/p" /proc/meminfo\`;ram=\`expr $ramexp\`;if [[ $ram -lt 10 ]];then echo -n " \[\e[00;31m\]RAM<$ram%\[\e[m\]";fi`\
#`disk=\`df . | sed -n "s/.* \([1-9]*[0-9]\)%.*/\1/p"\`;if [ $disk ];then if [[ $disk -gt 87 ]];then echo -n " \[\e[00;31m\]DISK>$disk%\[\e[m\]";fi;fi`\
# \[\e[00;$(if [[ ! -w $PWD ]];then echo -n 31;fi)m\]\w/\[\e[m\]\
# '

#2013-12-31 for some reason bash doesn't like )\ endings, need to use ) \ instead

#2013-12-31 calculate percentage with floating point
#function checkram {
# cram=$(arthpercent $(sed -n "N;s/^MemTotal:\s*\([0-9]*\) .*\nMemFree:\s*\([0-9]*\) .*/\2 \1/p" /proc/meminfo;))                                                                                                   
# echo -n $cram                                                                                                                                                                                                     
#}
#
#function arthpercent {
# t=$(($1*100-$2))
# p=0
# while [ $t -gt 0 ]
# do
#  t=$(($t-$2))
#  p=$((p+1))
# done
# echo $p
#}
#
#export PS1='\
#\[\e[00;$(($(printf "%u" "'\''$(whoami)")%6+31))m\]\u\[\e[m\]\
# \[\e[00;$(($(printf "%u" "'\''$(hostname)")%6+31))m\]\h\[\e[m\]\
# \[\e[00;36m\]`date +"%F\[\e\[m\]\[\e[00;32m\] %T\[\e\[m\]"`\
#`load=$(sed "s/\([0-9]*\)[.]\([0-9]*\).*/1\1\2/" /proc/loadavg);if [[ $load -gt 1090 ]];then echo -n " \[\e[00;31m\]LOAD>$(($load-1000))%\[\e[m\]";fi`\
#`ram=\`checkram\`;echo =$ram;if [[ $ram -lt 10 ]];then echo -n " \[\e[00;31m\]RAM<$ram%\[\e[m\]";fi`\
#`disk=$(df . | sed -n "s/.* \([1-9]*[0-9]\)%.*/\1/p");if [ $disk ];then if [[ $disk -gt 87 ]];then echo -n " \[\e[00;31m\]DISK>$disk%\[\e[m\]";fi;fi`\
# \[\e[00;$(if [[ ! -w $PWD ]];then echo -n 31;fi)m\]\w/\[\e[m\]\
# '

#2013-03-09 fixed bug related to empty $disk variable like df /proc
#PS1='\
#\[\e[00;$(($(printf "%u" "'\''$(whoami)")%6+31))m\]\u\[\e[m\]\
# \[\e[00;$(($(printf "%u" "'\''$(hostname)")%6+31))m\]\h\[\e[m\]\
# \[\e[00;36m\]`date +"%F\[\e\[m\]\[\e[00;32m\] %T\[\e\[m\]"`\
#$(load=$(sed "s/\([0-9]*\)[.]\([0-9]*\).*/1\1\2/" /proc/loadavg);if [[ $load -gt 1090 ]];then echo -n " \[\e[00;31m\]LOAD>$(($load-1000))%\[\e[m\]";fi)\
#$(ram=$(($(sed -n "N;s/^MemTotal:\s*\([0-9]*\) .*\nMemFree:\s*\([0-9]*\) .*/100*\2\/\1/p" /proc/meminfo;)));if [[ $ram -lt 10 ]];then echo -n " \[\e[00;31m\]RAM<$ram%\[\e[m\]";fi)\
#$(disk=$(df . | sed -n "s/.* \([1-9]*[0-9]\)%.*/\1/p");if [ $disk ];then if [[ $disk -gt 87 ]];then echo -n " \[\e[00;31m\]DISK>$disk%\[\e[m\]";fi;fi)\
# \[\e[00;$(if [[ ! -w $PWD ]];then echo -n 31;fi)m\]\w/\[\e[m\]\
# '

#Previous Verions

#2013-03-08 change CPU to LOAD which is more accurate as it's not just CPU but IO waits as well
#PS1='\
#\[\e[00;$(($(printf "%u" "'\''$(whoami)")%6+31))m\]\u\[\e[m\]\
# \[\e[00;$(($(printf "%u" "'\''$(hostname)")%6+31))m\]\h\[\e[m\]\
# \[\e[00;36m\]`date +"%F\[\e\[m\]\[\e[00;32m\] %T\[\e\[m\]"`\
#$(load=$(sed "s/\([0-9]*\)[.]\([0-9]*\).*/1\1\2/" /proc/loadavg);if [[ $load -gt 1090 ]];then echo -n " \[\e[00;31m\]LOAD>$(($load-1000))%\[\e[m\]";fi)\
#$(ram=$(($(sed -n "N;s/^MemTotal:\s*\([0-9]*\) .*\nMemFree:\s*\([0-9]*\) .*/100*\2\/\1/p" /proc/meminfo;)));if [[ $ram -lt 10 ]];then echo -n " \[\e[00;31m\]RAM<$ram%\[\e[m\]";fi)\
#$(disk=$(df . | sed -n "s/.* \([0-9]*[0-9]\)%.*/\1/p");if [[ $disk -gt 87 ]];then echo -n " \[\e[00;31m\]DISK>$disk%\[\e[m\]";fi)\
# \[\e[00;$(if [[ ! -w $PWD ]];then echo -n 31;fi)m\]\w/\[\e[m\]\
# '

#2013-01-28 added free memory and disk usage indicator
#PS1='\
#\[\e[00;$(($(printf "%u" "'\''$(whoami)")%6+31))m\]\u\[\e[m\]\
# \[\e[00;$(($(printf "%u" "'\''$(hostname)")%6+31))m\]\h\[\e[m\]\
# \[\e[00;37m\]`date +"%F %T"`\[\e[m\]\
#$(load=$(sed "s/\([0-9]*\)[.]\([0-9]*\).*/1\1\2/" /proc/loadavg);if [[ $load -gt 1090 ]];then echo -n " \[\e[00;31m\]CPU>$(($load-1000))%\[\e[m\]";fi)\
#$(ram=$(($(sed -n "Ns/^MemTotal:\s*\([0-9]*\) .*\nMemFree:\s*\([0-9]*\) .*/100*\2\/\1/p" /proc/meminfo;)));if [[ $ram -lt 10 ]];then echo -n " \[\e[00;31m\]RAM<$ram%\[\e[m\]";fi)\
#$(disk=$(df . | sed -n "s/.* \([0-9]*[0-9]\)%.*/\1/p");if [[ $disk -gt 87 ]];then echo -n " \[\e[00;31m\]DISK>$disk%\[\e[m\]";fi)\
# \[\e[00;$(if [[ ! -w $PWD ]];then echo -n 31;fi)m\]\w/\[\e[m\]\
# '

#2013-01-26 added cpu load indicator
#PS1='\
#\[\e[00;$(($(printf "%u" "'\''$(whoami)")%6+31))m\]\u\[\e[m\]\
# \[\e[00;$(($(printf "%u" "'\''$(hostname)")%6+31))m\]\h\[\e[m\]\
# \[\e[00;37m\]`date +"%F %T"`\[\e[m\]\
#$(load=$(sed "s/\([0-9]*\)[.]\([0-9]*\).*/1\1\2/" /proc/loadavg);if [[ $load -gt 1090 ]];then echo -n " \[\e[00;31m\][CPU>$(($load-1000))%]\[\e[m\]";fi)\
# \[\e[00;$(if [[ ! -w $PWD ]];then echo -n 31;fi)m\]\w/\[\e[m\]\
# '

#2013-01-25
#PS1="\[\e[00;\$((\$(printf '%u' \"'\$(whoami)\")%6+31))m\]\u\[\e[m\]\
#\[\e[00;\$((\$(printf '%u' \"'\$(hostname)\")%6+31))m@\]\h\[\e[m\]\
#\[\e[00;30m\]0.1\[\e[m\]\
#\[\e[00;\$((32-\$(printf "%.0f" \$(cat /proc/loadavg | sed 's/\([0-9.]*\).*/\1/'))%2))m\][\`date +'%F %T'\`]\[\e[m\]\
#\[\e[00;\$(if [[ -w \$PWD ]];then echo -n 37;else echo -n 31;fi)m\]\w/\[\e[m\]\
#"

#2013-01-24  with background (which seems to hurt my eyes)
#PS1="\[\e[48;5;\$(echo -n \$user_bg)m\e[38;5;\$(echo -n \$user_fg)m\]\u\[\e[m\e[m\]\
#\[\e[48;5;\$(echo -n \$host_bg)m\e[38;5;\$(echo -n \$host_fg)m@\]\h\[\e[m\e[m\]\
#\[\e[48;5;27m\e[38;5;250m\][\`date +'%F %T'\`]\[\e[m\e[m\]\
#\[\e[48;5;70m\e[38;5;238m\]\w/\[\e[m\e[m\]\
# "

#html prompt experiment
#PS1="\<div style\=\'fontsize\:large\'\>hi\<\/div\>"

#PS1 longer than 79 characters and ctrl+U will cut of previous line for aterm, ok for bash
#can set aterm geomtry aterm -g 81x24 which fixes the problem
#PS1='12345678901234567890123456789012345678901234567890123456789012345678901234567890'
#maybe use printf "%.80s" string to limit the number of characters

#braille indicator ⣿⣷⣶⣦⣤⣄⣀⡀ (problem with tty width not correct)
#load=$(($(cat /proc/loadavg | sed 's/\([0-9]*\)[.]\([0-9]*\).*/1\1\2/')-1000));if [[ $load -gt 80 ]];then echo -n ⣿;elif [[ $load -gt 70 ]];then echo -n ⣷;elif [[ $load -gt 60 ]];then echo -n ⣶;elif [[ $load -gt 50 ]];then echo -n ⣦;elif [[ $load -gt 40 ]];then echo -n ⣤;elif [[ $load -gt 30 ]];then echo -n ⣄;elif [[ $load -gt 20 ]];then echo -n ⣀;else echo -n ⡀;fi
