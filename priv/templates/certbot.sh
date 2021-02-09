#!/bin/sh
echo resertech@snael1 | sudo apt-get install -y software-properties-common 
 sudo add-apt-repository -y ppa:certbot/certbot 
 sudo apt-get update 
 sudo apt-get install -y certbot
 sudo cp letsencrypt.ini /etc/letsencrypt/

 sudo certbot certonly --config /etc/letsencrypt/letsencrypt.ini