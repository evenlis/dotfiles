# Set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Permanent custom aliases
alias poweroff='sudo poweroff'
alias pm-hibernate='sudo pm-hibernate'
alias lsext='ls --sort=extension'
alias ls='ls -F --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -A --color=auto'
alias l='ls -F --color=auto'
alias egrep='egrep --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
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
    pacmd set-default-sink "alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1"
}

hdmi-audio-off(){
    pacmd set-default-sink "alsa_output.pci-0000_00_1b.0.analog-stereo"
}

hdmi-off() {
    xrandr --output LVDS-1 --auto --output HDMI-1 --off && pacmd set-default-sink "alsa_output.pci-0000_00_1b.0.analog-stereo"
}

hdmi-single() {
    xrandr --output LVDS-1 --off --output HDMI-1 --auto && pacmd set-default-sink "alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1"
}

hdmi-clone() {
    xrandr --output LVDS-1 --auto --output HDMI-1 --auto
}

hdmi-extend-right(){
    xrandr --output HDMI-1 --auto --output LVDS-1 --auto --left-of HDMI-1
}

hdmi-extend-left(){
    xrandr --output HDMI-1 --auto --output LVDS-1 --auto --right-of HDMI-1
}

hdmi-extend-above(){
    xrandr --output HDMI-1 --auto --output LVDS-1 --auto --below HDMI-1
}

hdmi-extend-below(){
    xrandr --output HDMI-1 --auto --output LVDS-1 --auto --above HDMI-1
}

vga-off() {
    xrandr --output VGA-1 --off --output LVDS-1 --auto
}

vga-single(){
    xrandr --output VGA-1 --auto --output LVDS-1 --off
}

vga-clone(){
    xrandr --output LVDS-1 --auto --output VGA-1 --auto --same-as LVDS-1
}

vga-extend-right(){
    xrandr --output VGA-1 --auto --output LVDS-1 --auto --left-of VGA-1
}

vga-extend-left(){
    xrandr --output VGA-1 --auto --output LVDS-1 --auto --right-of VGA-1
}

vga-extend-above(){
    xrandr --output VGA-1 --auto --output LVDS-1 --auto --below VGA-1
}

vga-extend-below(){
    xrandr --output VGA-1 --auto --output LVDS-1 --auto --above VGA-1
}
