# Set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Temporary custom aliases
alias odinadmin="cd ~/micronax/odin-image && ls"
alias odinserver="cd ~/micronax/odin-server && ls"
alias odinclient="cd ~/micronax/odin && ls"

# Permanent custom aliases
alias poweroff='sudo poweroff'
alias pm-hibernate='sudo pm-hibernate'
alias lsext='ls --sort=extension'
alias ls='ls -F --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -A --color=auto'
alias l='ls -F --color=auto'
alias -- ¨="cd ~"
alias -- -="cd -"
alias egrep='egrep --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias ..l="cd .. && ls"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias mkdir="mkdir -pv"
alias diff="colordiff"
alias wget="wget -c"
alias chrome="google-chrome"
alias zls="unzip -vl"
alias tls="tar -tvf"
alias tgzls="tar -ztvf"
alias tbz2ls="tar -jtvf"
alias untar="tar -xvf"
alias untargz="tar -zxvf"
alias untarbz2="tar -jxvf"
alias unbz2="bzip2 -d"
alias ctar="tar -cvf"
alias ctarbz2="tar -cjvf"
alias ctargz="tar -czvf"
alias czip="zip -r"

# Use emacs keybindings even if the EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

mkdircd(){
    mkdir -p "$@" && eval cd "\"\$$#\"";
}

m() {
    echo $1 | bc -l
}

hdmi-audio() {
    pacmd set-default-sink "alsa_output.pci-0000_00_03.0.hdmi-stereo-extra2"
}

hdmi-audio-off(){
    pacmd set-default-sink "alsa_output.pci-0000_00_1b.0.analog-stereo"
}

hdmi-off() {
    xrandr --output eDP1 --auto --output HDMI1 --off && pacmd set-default-sink "alsa_output.pci-0000_00_1b.0.analog-stereo"
}

hdmi-single() {
    xrandr --output eDP1 --off --output HDMI1 --auto && pacmd set-default-sink "alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1"
}

hdmi-clone() {
    xrandr --output eDP1 --auto --output HDMI1 --auto
}

hdmi-extend-right(){
    xrandr --output HDMI1 --auto --output eDP1 --auto --left-of HDMI1
}

hdmi-extend-left(){
    xrandr --output HDMI1 --auto --output eDP1 --auto --right-of HDMI1
}

hdmi-extend-above(){
    xrandr --output HDMI1 --auto --output eDP1 --auto --below HDMI1
}

hdmi-extend-below(){
    xrandr --output HDMI1 --auto --output eDP1 --auto --above HDMI1
}

vga-off() {
    xrandr --output VGA1 --off --output eDP1 --auto
}

vga-single(){
    xrandr --output VGA1 --auto --output eDP1 --off
}

vga-clone(){
    xrandr --output eDP1 --auto --output VGA1 --auto --same-as eDP1
}

vga-extend-right(){
    xrandr --output VGA1 --auto --output eDP1 --auto --left-of VGA1
}

vga-extend-left(){
    xrandr --output VGA1 --auto --output eDP1 --auto --right-of VGA1
}

vga-extend-above(){
    xrandr --output VGA1 --auto --output eDP1 --auto --below VGA1
}

vga-extend-below(){
    xrandr --output VGA1 --auto --output eDP1 --auto --above VGA1
}

monitors-off(){
    xrandr --output VGA1 --off --output HDMI1 --off --output eDP1 --auto
}

triple-monitor(){
    if [ $# -lt "2" ] || [ $# -gt "4" ]; then
	echo -e "Usage: \n\ttriple-monitor <hdmipos> <vgapos>[ <rotate-hdmi> <rotate-vga>]"
	return
    fi
    VALIDPARAMS=false
    if [ $# = "3" ]; then
	if [ $3 = "left" ] || [ $3 = "right" ] || [ $3 = "normal" ]; then
	    xrandr --output HDMI1 --rotate $3
	else
	    echo -e "Invalid argument \"$3\""
	    return
	fi
    elif [ $# = "4" ]; then
	if [ $3 = "left" ] || [ $3 = "right" ] || [ $3 = "normal" ]; then
	    xrandr --output HDMI1 --rotate $3
	else
	    echo -e "Invalid argument \"$3\""
	    return
	fi
	if [ $4 = "left" ] || [ $4 = "right" ] || [ $4 = "normal" ]; then
	    xrandr --output VGA1 --rotate $4
	else
	    echo -e "Invalid argument \"$4\""
	fi
    else
	xrandr --output HDMI1 --rotate normal --output VGA1 --rotate normal
    fi
    if [ $1 = "left" ]; then
	if [ $2 = "right" ]; then
	    xrandr --output HDMI1 --auto --left-of eDP1 --output VGA1 --auto --right-of eDP1
	elif [ $2 = "mid" ]; then
	    xrandr --output  VGA1 --auto --left-of eDP1 --output HDMI1 --auto --left-of VGA1
	fi
    elif [ $1 = "mid" ]; then
	if [ $2 = "left" ]; then
	    xrandr --output HDMI1 --auto --left-of eDP1 --output VGA1 --auto --left-of HDMI1
	elif [ $2 = "right" ]; then
	    xrandr --output HDMI1 --auto --right-of eDP1 --output VGA1 --auto --right-of HDMI1
	fi
    fi
}

powersave(){
    ON=$1
    if [ $ON = "true" ]; then
	sudo pm-powersave true
	xbacklight -set 0
    elif [ $ON = "false" ]; then
	sudo pm-powersave false
	xbacklight -set 100
    fi
}
