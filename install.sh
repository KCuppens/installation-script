#!/bin/bash

# Defined Colors
RESET='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'

# Child Fucntions
pip_install() {
    pip3 install celery
    pip3 install redis
    pip3 install django-celery-beat
    pip3 install django-celery-results
}

# Parent Functions
nginx() {
    if [ -f /usr/sbin/nginx ]
    then
        echo -e "$GREEN Nginx already installed \n $RESET"
    else
        echo -e "$YELLOW Installing nginx.......... \n $RESET"
        sudo apt update
        sudo apt install nginx -y
        sudo service nginx start
        echo -e "$GREEN Nginx installed successfully.......... \n$RESET"
    fi
}

gunicorn() {
    if [ -f /usr/bin/gunicorn ]
    then
        echo -e "$GREEN Gunicorn already installed \n $RESET"
    else
        echo -e "$YELLOW Installing gunicorn.......... \n $RESET"
        sudo apt update
        sudo apt install gunicorn -y
        echo -e "$GREEN gunicorn installed successfully.......... \n$RESET"
    fi
}

supervisor() {
    if [ -f /usr/bin/supervisord ]
    then
        echo -e "$GREEN Supervisor already installed \n $RESET"
    else
        echo -e "$YELLOW Installing supervisor.......... \n $RESET"
        sudo apt update
        sudo apt install supervisor -y
        echo -e "$GREEN supervisor installed successfully.......... \n $RESET"
    fi
}

varnish() {
    if [ -f /usr/sbin/varnishd ]
    then
        echo -e "$GREEN Varnish already installed \n $RESET"
    else
        echo -e "$YELLOW Installing varnish.......... \n $RESET"
        curl -L https://packagecloud.io/varnishcache/varnish41/gpgkey | sudo apt-key add -
        sudo tee /etc/apt/sources.list.d/varnishcache_varnish41.list <<EOT
deb https://packagecloud.io/varnishcache/varnish41/ubuntu/ trusty main
deb-src https://packagecloud.io/varnishcache/varnish41/ubuntu/ trusty main
EOT
        sudo apt update
        sudo apt install varnish -y
       # sudo cp varnish.vcl /etc/varnish/default.vcl
       # sudo service varnish restart 
        echo -e "$GREEN varnish installed successfully.......... \n $RESET"
    fi
}

redis() {
    if [[ -f /usr/bin/redis-server && -f /usr/bin/redis-cli ]]
    then
        echo -e "$GREEN Redis already installed \n $RESET"
    else
        echo -e "$YELLOW Installing redis.......... \n $RESET"
        sudo apt update
        sudo apt install redis-server -y
        echo -e "$GREEN redis installed successfully.......... \n $RESET"
    fi
}

celery() {
    if [ -f /usr/bin/python3 ]
    then
        if [ -f /usr/bin/pip3 ]
        then
            echo -e "$YELLOW Installing celery.......... \n $RESET"
            pip_install
            echo -e "$GREEN celleryinstalled successfully.......... \n $RESET"
        else
            echo -e "$YELLOW Installing celery.......... \n $RESET"
            sudo apt update
            sudo apt install python3-pip -y
            pip_install
            echo -e "$GREEN celleryinstalled successfully.......... \n $RESET"
        fi
    else
        echo -e "$YELLOW Installing Python.......... \n $RESET"
        sudo apt update
        sudo apt install python3 python3-pip -y

        echo -e "$YELLOW Installing celery.......... \n $RESET"
        pip_install
        echo -e "$GREEN celleryinstalled successfully.......... \n $RESET"
    fi
}

git_cli() {
    if [ -f /usr/bin/git ]
    then
        echo -e "$GREEN Git already installed \n $RESET"
    else
        echo -e "$YELLOW Installing git.......... \n $RESET"
        sudo apt update
        sudo apt install git -y
        echo -e "$GREEN git installed successfully....... \n $RESET"
    fi
}



# Run the above defined fucntions
nginx
gunicorn
supervisor
varnish
redis
celery
git_cli

# Update the server
echo -e "$YELLOW Updating.......... \n $RESET"
sudo apt update