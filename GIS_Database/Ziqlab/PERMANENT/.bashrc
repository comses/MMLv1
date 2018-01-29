test -r ~/.alias && . ~/.alias
PS1='GRASS 6.4.3 (PPNB):\w > '
PROMPT_COMMAND="'/usr/lib/grass64/etc/prompt.sh'"
export PATH="/usr/lib/grass64/bin:/usr/lib/grass64/scripts:/home/comparch2/.grass6/addons:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"
export HOME="/home/comparch2"
export GRASS_SHELL_PID=$$
trap "echo \"GUI issued an exit\"; exit" SIGQUIT
