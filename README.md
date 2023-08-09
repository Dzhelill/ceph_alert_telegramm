# скрипт запускает команду  и сравнивает ее вывод с предыдущем ее выводом,


# (если это первый запуск, то просто запишет его в /tmp/laststatus.txt и вышлет результат в телегу)


# при следующем запуске скрипт сравнит вывод ceph health detail с текстовиком и если он тотже, 


# то ничего не делает,


# если результат отличается, то перезапишет laststatus.txt и отошлет содержимое в телегу﻿


# планировщик запускает скрипт раз в минуту таким образом с этим интервалом проверяет состояние cepha

 

# создаем пустой текстовый laststatus.txt файл в /tmp/
 
   
    nano /tmp/laststatus.txt


# создаем файл где нибудь. к примеру /usr/local/bin/ с расширением .sh

    
    nano /usr/local/bin/send.sh


# вставляем туда текст: 


STATUS=$(ceph health detail)


LASTSTATUS=$(cat /tmp/laststatus.txt)


if [ "$(ceph health detail)" != "$LASTSTATUS" ]


	then


                curl -s -X POST https://api.telegram.org/"токен_бота"/sendMessage -d chat_id="id_чата" -d text="имя_CEPH 


$STATUS"


fi


ceph health detail > /tmp/laststatus.txt


# укажите "токен_бота"


# укажите  "id_чата"


# укажите  text="имя_CEPH"


# cделаем наш файл исполняемым
    

	chmod 777 /usr/local/bin/send.sh


# создаем планировщик на выполнение /usr/local/bin/send.sh , в нашем случае, раз в минуту


	crontab -e


# в открывшемся редакторе вставляем:


    * * * * * /usr/bin/local/send.sh


#сохраняем.


#проверяем:
    crontab -l
		# вывод должен быть таким
			* * * * * /usr/bin/local/send.sh

