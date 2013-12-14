nfn-vagrant
===========

Vagrant files to build a notes from nature development server.

To use this code you need Vagrant (http://www.vagrantup.com/) and Virtual Box (https://www.virtualbox.org/). I'll cover how to get the machine up and running during the first Tech Up! session, but the basics are:

Install Vagrant
Install Virtual Box
Download or clone the vagrant code.
Open a command prompt in the directory with the vagrant code.
run: vagrant up
(The first time this is run, it will download the base image and might take a little bit).

A virtual box window will appear with a login prompt, but wait for the text in the vagrant window to say something like:

notice: Finished catalog run in 64.78 seconds

You can now log into the machine with vagrant/vagrant (this user has sudo access) and get to the notes from nature interface via a forwarded port at: http://localhost:9294/ . Notes from nature is installed at /usr/local/notesFromNature , so if you want to check out a branch you can go to the directory and run git checkout branchname . The notes from nature application is run using a program called hem in /usr/local/notesFromNature/node_modules/hem/bin .

You can kill the server that vagrant starts with # sudo pkill node , and start a new server with ./node_modules/hem/bin/hem server from the notesFromNature directory.
