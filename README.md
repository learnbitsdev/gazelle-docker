# gazelle-docker

So, you want to develop a BitTorrent tracker, huh? Great! Let's do it.

## Requirements

This guide assumes that you will be developing on a Linux based system. We recommend using a local machine running either Linux or a Linux VM. You will need the following software installed before continuing:

  * Git
  * Docker (https://docs.docker.com/engine/installation/)
  * Docker Compose (https://docs.docker.com/compose/install/)

## About the environment

Docker is our current approach for easily deploying the entire tracker stack on any host. At the time of writing, these are the containers defined for this stack:

  * web
    * Hosts the nginx + PHP7 server which serves up the tracker's web interface (Gazelle)
  * ocelot
    * The BitTorrent tracker itself (this is implemented in C++)
  * mysql
    * The database that holds everything. Gazelle and Ocelot use this to share data
    * NOTE: On the very first boot of this container, the database will be populated with the default Gazelle/Oppaitime SQL file
  * memcached
    * Requirement for Gazelle. Caches site data and keeps things running fast
  * sphinx
    * Requirement for Gazelle. The search indexing daemon. This takes torrent data and builds indicies so that searching can be performed on it
  * phpmyadmin
    * Simplifies DB administration/debugging during development

## Clone the repos

Before you can fire up Gazelle, you'll need to clone it (in addition to this repo). Pick a directory to keep your dev resources in and pull down the repos:

    git clone https://git.oppaiti.me/Oppaitime/Gazelle.git
    git clone https://github.com/learnbitsdev/gazelle-docker.git

It is important that you clone both of these repos to the same directory. Also, do not rename the "Gazelle" directory.

## Starting everything

Before starting your dev stack, you'll want to make sure the default paths/ports are suitable (typically you will not need to change them). Open "up.sh" in your editor and modify the variables at the top as needed.

Now simply run the "up.sh" script. This will be the command you'll run any time you want to start the development stack.

    ./up.sh

This will bring up all the containers and redirect all output to your console. If this is the first time you've run this command, go get a coffee. It takes a while for the web and ocelot containers to build (as code is being compiled from source). On the first run, the DB import will be the last thing to happen (see next section).

## The initial DB import

Note that on the first run of ./up.sh, mysql will take much longer than everything else to come up and import the stock database. You'll likely see sphinx and ocelot crash because mysql has not been initialized yet. That's okay. Just wait.

Once the console stops outputting text for a minute or so, mysql should be settled. If you see this at the end of the output, mysql is still importing the initial DB:

    mysql         | /usr/local/bin/docker-entrypoint.sh: running /docker-entrypoint-initdb.d/gazelle.sql
    mysql         | mysql: [Warning] Using a password on the command line interface can be insecure.

After the DB finishes importing and the console has settled, press Ctrl+C. Run ./up.sh again and mysql should come up in time for sphinx and ocelot to connect to it. Unless your database container is deleted, in the future you will only need to run "./up.sh" once. Note that you are now seeing the output of all the containers (you will not be returned to the shell). Pressing Ctrl+C will terminate the entire stack (do this once you're done developing).

## Stopping everything

If for some reason you become detached from your console or need to stop the tracker dev stack, you can run the "./down.sh" script in this directory.

## Go forth. Develop.

At this point, you should be able to browse to the tracker at http://localhost:8080 and access phpMyAdmin at http://localhost:8081

The TCP tracker (ocelot) will be running on localhost:34000

As the web container references your "Gazelle" directory, you can simply edit the files and see the changes immediately.

## Creating your first tracker account

Prior to creating the first account on the tracker, you will need to load in an encryption key. This is required every time the tracker is restarted. You can load a key in at http://localhost:8080/tools.php?action=database_key It does not matter what you use for this key, as long as you are consistent.

Once you've loaded in the key, you can then register an account at http://localhost:8080/register.php
