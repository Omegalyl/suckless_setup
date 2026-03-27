alias console="ssh console@10.194.71.42 -p"
alias wifi_connect="iwctl station wlan0 connect"
alias wifi_scan="iwctl station wlan0 scan && iwctl station wlan0 get-networks"
alias wifi_show="iwctl station wlan0 show"
alias c2c='xclip -selection clipboard'
alias plantuml='java -jar ~/bin/plantuml.jar'
alias openui_pull='docker pull ghcr.io/open-webui/open-webui:main'
alias openui_create='docker run -d -p 3000:8080 -e WEBUI_AUTH=False -v open-webui:/app/backend/data --name open-webui ghcr.io/open-webui/open-webui:main'
alias gss="git status"
alias gaa="git add ."
alias myip="curl -s https://api.ipify.org || curl -s https://ifconfig.me"
