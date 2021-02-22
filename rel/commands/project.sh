#!/bin/sh
cd /web_acc
echo resertech@snael1 | sudo -S tar xfz web_acc.tar.gz
sudo mv /web_acc/web_acc.tar.gz /web_acc/releases/0.0.1/
sudo /web_acc/bin/web_acc stop
sudo /web_acc/bin/web_acc migrate
sudo /web_acc/bin/web_acc start
