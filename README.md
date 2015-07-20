# docker-ampache

Docker container for [Ampache][3]

"A web based audio/video streaming application and file manager allowing you to access your music & videos from anywhere, using almost any internet enabled device."

## Install dependencies

  - [Docker][2]

To install docker in Ubuntu 14.04 use the commands:

    $ sudo apt-get update
    $ sudo apt-get install docker.io

 To install docker in other operating systems check [docker online documentation][4]

## Usage

To run container use the command below:

    $ docker run -d -p xxxx:80 quantumobject/docker-ampache

Check port and point your browser to http://[ip]:xxxx/  to initially configure your Ampache.

where mysql user will be root and password will be mysqlpsswd

when done please execute this command for security and remove the install script:

    $ docker exec -it container_id after_install

## More Info

About Ampache [ampache.org][1]

To help improve this container [quantumobject/docker-ampache][5]

[1]:http://ampache.org/
[2]:https://www.docker.com
[3]:https://github.com/ampache/ampache/releases
[4]:http://docs.docker.com
[5]:https://github.com/QuantumObject/docker-ampache

