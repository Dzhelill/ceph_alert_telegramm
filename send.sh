#!/bin/bash
STATUS=$(ceph health detail)
LASTSTATUS=$(cat /tmp/laststatus.txt)

if [ "$(ceph health detail)" != "$LASTSTATUS" ]
then
                curl -s -X POST https://api.telegram.org/"токен_бота"/sendMessage -d chat_id="id_чата" -d text="имя_CEPH 
$STATUS"
fi
ceph health detail > /tmp/laststatus.txt

