#======================================================================
#
# function.sh -
#
# Created by liubang on 2018/11/22
# Last Modified: 2018/11/22 21:52:49
#
#======================================================================

if [ -z "$_INIT_SH_NOFUN" ]; then
    _INIT_SH_NOFUN=1
else
    return 0
fi

# skip if in non-interactive mode
case "$-" in
*i*) ;;
*) return ;;
esac

q_weather() {
    local city="${1:-beijing}"
    if [ -x "$(which wget)" ]; then
        wget -qO- "wttr.in/~${city}"
    elif [ -x "$(which curl)" ]; then
        curl "wttr.in/~${city}"
    fi
}

q_server() {
    local port="${1:-80}"
    cmd="python3 -m http.server ${port}"
    echo "$cmd"
    eval "$cmd"
}

q_set_http_proxy() {
    proxy="http://127.0.0.1:7890"
    export HTTP_PROXY=$proxy
    export HTTPS_PROXY=$proxy
    export http_proxy=$proxy
    export https_proxy=$proxy
}

q_unset_http_proxy() {
    unset http_proxy
    unset https_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY
}

q_cmake_ecc() {
    cmd="cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=on $@"
    echo $cmd
    eval $cmd
}

# get all IPs
q_ips() {
    case $(uname) in
    Darwin | *BSD)
        ip=$(ifconfig | grep -E 'inet.[0-9]' | grep -v '127.0.0.1' | awk '{ print $2}')
        ;;
    *)
        ip=$(hostname --all-ip-addresses | tr " " "\n" | grep -v "0.0.0.0" | grep -v "127.0.0.1")
        ;;
    esac
    echo "${ip}"
}

# get public IP
q_myip() {
    if command -v curl &>/dev/null; then
        curl ifconfig.co
    elif command -v wget &>/dev/null; then
        wget -qO- ifconfig.co
    fi
}
