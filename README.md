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
- <b>[TODO]</b> Setup the homestead environment for the new created project
- <b>[TODO]</b> Some fancy styling for the terminal

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

