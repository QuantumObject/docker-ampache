# docker-ampache

Docker container for [Ampache][3]

"A web based audio/video streaming application and file manager allowing you to access your music & videos from anywhere, using almost any internet enabled device."

## Install dependencies

  - [Docker][2]

To install docker in Ubuntu 16.04 use the commands:

    $ sudo apt-get update
    $ sudo wget -qO- https://get.docker.com/ | sh

 To install docker in other operating systems check [docker online documentation][4]

## Usage

If you need a MySQL database you can link container :

    $ docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=mysecretpassword -d mysql

or you can used a pre-existing mysql container.  
  
Them create and link to Ampache container

    $ docker run -d -p xxxx:80 --link some-mysql:db quantumobject/docker-ampache 

where when been ask for database need to replace localhost for db.

Check port and point your browser to http://[ip]:xxxx/  to initially configure your Ampache.

when done please execute this command for security and remove the install script:

    $ docker exec -it container_id after_install
    
to add the media files for this container you can used the VOLUME /var/data when creating the container :

    $ docker run -d -p xxxx:80 -v /src/data:/var/data --link some-mysql:db quantumobject/docker-ampache

## More Info

About Ampache [ampache.org][1]

To help improve this container [quantumobject/docker-ampache][5]

For additional info about us and our projects check our site [www.quantumobject.org][6]

[1]:http://ampache.org/
[2]:https://www.docker.com
[3]:https://github.com/ampache/ampache/releases
[4]:http://docs.docker.com
[5]:https://github.com/QuantumObject/docker-ampache
[6]:https://www.quantumobject.org/
