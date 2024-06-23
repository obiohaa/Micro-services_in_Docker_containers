      ¯\_(ﭣ)_/¯
 IT WORKS ON MY MACHINE

------------------------

docker pull mysql/mysql-server:latest


--------------------

docker images ls

-------------------------

docker run --name <container_name> -e MYSQL_ROOT_PASSWORD=<my-secret-pw> -d mysql/mysql-server:latest

-------------------------

docker ps -a

---------------------

CONTAINER ID   IMAGE                                COMMAND                  CREATED          STATUS                             PORTS                       NAMES
7141da183562   mysql/mysql-server:latest            "/entrypoint.sh mysq…"   12 seconds ago   Up 11 seconds (health: starting)   3306/tcp, 33060-33061/tcp   mysql-server

----------------------

docker exec -it <container_name> mysql -uroot -p

-------------------------

docker network create --subnet=172.18.0.0/24 tooling_app_network 

-----------------------------

export MYSQL_PW=<root-secret-password>

-------------------

docker run --network tooling_app_network -h mysqlserverhost --name=mysql-server -e MYSQL_ROOT_PASSWORD=$MYSQL_PW  -d mysql/mysql-server:latest 


-------------------

docker ps -a

---------------------

CONTAINER ID   IMAGE                                COMMAND                  CREATED          STATUS                             PORTS                       NAMES
7141da183562   mysql/mysql-server:latest            "/entrypoint.sh mysq…"   12 seconds ago   Up 11 seconds (health: starting)   3306/tcp, 33060-33061/tcp   mysql-server

-------------------------

CREATE USER '<user>'@'%' IDENTIFIED BY '<client-secret-password>';
GRANT ALL PRIVILEGES ON * . * TO '<user>'@'%';


----------------------------

CREATE USER '<user>'@'%' IDENTIFIED BY '<client-secret-password>';
GRANT ALL PRIVILEGES ON * . * TO '<user>'@'%';

-----------------------

docker exec -i mysql-server mysql -uroot -p$MYSQL_PW < ./create_user.sql

---------------------------

mysql: [Warning] Using a password on the command line interface can be insecure.


--------------------------

docker run --network tooling_app_network --name mysql-client -it --rm mysql mysql -h mysqlserverhost -u <user-created-from-the-SQL-script> -p

------------------------------

https://github.com/dareyio/tooling

-----------------------------

git clone https://github.com/darey-devops/tooling.git

-----------------------------------

export tooling_db_schema=~/tooling/html/tooling_db_schema.sql


---------------------------------

docker exec -i mysql-server mysql -uroot -p$MYSQL_PW < $tooling_db_schema


----------------------------

$servername = "mysqlserverhost";
$username = "<user>";
$password = "<client-secret-password>";
$dbname = "toolingdb";

-------------------------

https://www.youtube.com/watch?v=hnxI-K10auY

https://docs.docker.com/develop/develop-images/dockerfile_best-practices/

---------------------

docker build -t tooling:0.0.1 .

-------------------------

docker run --network tooling_app_network -p 8085:80 -it tooling:0.0.1

--------------------------

AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.18.0.3. Set the 'ServerName' directive globally to suppress this message

-----------------------------
https://github.com/dareyio/php-todo

------------------------------

version: "3.9"
services:
  tooling_frontend:
    build: .
    ports:
      - "5000:80"
    volumes:
      - tooling_frontend:/var/www/html

-------------------------------

docker-compose --version
docker-compose version 1.28.5, build c4eb3a1f

-----------------------------------

version: "3.9"
services:
  tooling_frontend:
    build: .
    ports:
      - "5000:80"
    volumes:
      - tooling_frontend:/var/www/html
    links:
      - db
  db:
    image: mysql:5.7
    restart: always
    environment:
      MYSQL_DATABASE: <The database name required by Tooling app >
      MYSQL_USER: <The user required by Tooling app >
      MYSQL_PASSWORD: <The password required by Tooling app >
      MYSQL_RANDOM_ROOT_PASSWORD: '1'
    volumes:
      - db:/var/lib/mysql
volumes:
  tooling_frontend:
  db:

------------------------------------------

docker-compose -f tooling.yaml  up -d 

docker compose ls
