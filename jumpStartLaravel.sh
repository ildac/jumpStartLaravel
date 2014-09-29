#!/bin/sh

#  jumpStartLaravel.sh
#  An interactive script that does for you the most common operation when setting up a new Laravel project.
#  The requirements to run the script are:
#   - composer
#   - git
#   - curl
#   - homestead
#
#  Created by ilDac on 27/09/14.
#  Updated by ilDac on 29/09/14.
#

#if no project name is specified, composer will use the default project name "laravel"
while getopts "n:" flag
do
    projectName=$OPTARG
done


#create the new project with composer
echo "Initializating the project via Composer"
composer create-project laravel/laravel $projectName

cd "$projectName"

#configure permissions on folder
echo "Granting write permissions to app/storage"
chmod -R 0777 app/storage

#setup a local environment?
echo "Do you want to setup a local environment for testing?[yes,default:no]"
read localEvironment

if [ "$localEvironment" == "yes" ] || [ "$localEvironment" == "y" ]; then
    echo "Which is the name of your machine?[default:homestead]";
    echo "If you are using vagrant/homestead and you did not change the default machine name, just hit enter";
    read machineName;

    if ([ "$machineName" != "homestead" ] && [ "$machineName" != "" ]); then
        find bootstrap -name 'start.php' -exec sed -i '' -e 's/your-machine-name/$machineName/g' {} \; && echo "Local environment name set to $machineName"
    else
        echo "The default setings are enough for you"
    fi
else
    echo "Skipping local environment configuration";
fi

#git initialization
echo "Do you want to initialze e git repository for this project? [yes, default:no]"
read initializeGitRepo;

if [ "$initializeGitRepo" == "yes" ] || [ "$initializeGitRepo" == "y" ]; then
    git init
    #add external repository for the project (like bitbucket or github)?
    echo "add external repository for the project (like bitbucket or github)? [yes, default:no]"
    read externalRepoAddress

    if [ "$externalRepoAddress" == "yes" ] || [ "$externalRepoAddress" == "y" ]; then
        echo "Enter the origin repository address: "
        read originRepoAdrress
        git remote add origin "$originRepoAdrress"
    fi
    #.gitignore autodownload from github download .gitingnore from here:
    echo "Do you want to auto setup the laravel optimized git ignore file? [yes, default:no]"
    echo "The .gitignore file will be downloaded from the official Laravel GitHub repository and put in the git root of your project"
    read setupGitIgnore
    if [ "$setupGitIgnore" == "yes" ] || [ "$setupGitIgnore" == "y" ]; then
        curl -o .gitignore https://raw.githubusercontent.com/laravel/laravel/master/.gitignore
    fi
else
    echo "No git repo added"
fi

#setup homestead machine for the new site

