jumpStartLaravel
================

An interactive script that does for you the most common operation when setting up a new Laravel project.
The requirements to run the script are:
    - composer
    - git
    - curl
    - homestead

<i>Tested on OsX Mavericks 10.9</i>

What it does
-------------

- Initialize the project, via composer
- Set the right permissions to folders
- Initialize the local environment
- Initialize git repository with an external "origin"
- Download a standard laravel .gitignore file
- Setup the Homestead environment for the new created project
- Add the new local address to the /etc/hosts file

What it will do
---------------
- <b>[TODO]</b> Substitute the question (yes/no) with command option
- <b>[TODO]</b> Fancy and coloured terminal styling

Usage
-----

Just point your terminal in the folder where you want to put the root of the project, and type:

```
jumpStartLaravel.sh -n "projectName"
```

Installation
------------

Just clone this repo on your machine, give it the execution rights with this command:

```
chmod +x jumpStartLaravel.sh
```

<i>Inspired by: </i>
- [Rapid Laravel configuration](http://fideloper.com/laravel-4-uber-quick-start-with-auth-guide)
- [Regular Expression to modify the configuration file](http://stackoverflow.com/a/5723884/811858)

