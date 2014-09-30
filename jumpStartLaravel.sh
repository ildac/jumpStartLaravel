#!/bin/sh

#  jumpStartLaravel.sh
#  An interactive script that does for you the most common operation when setting up a new Laravel project.
#  The requirements to run the script are:
#   - composer
#   - git
#   - curl
#   - homestead
#  Usage:
#	jumpStartLaravel.sh -gih -o http://git.your.repo/address -l homestead  <projectName>
#  Options:
#	- -g: initialize the git repository
#	- -o: to set the remote repo address (without this no remote repository will be set)
# 	- -i: download the .gitignore file in the directory
#	- -h: add a new site in the Homestead configuration
#	- -l <localMachineName>: setup the laravel local environment, by default localMachineName is set to "homestead" that is the default one 
#
#  Created by ilDac on 27/09/14.
#  Updated by ilDac on 30/09/14.
#

# initialization
initializeGitRepo="no"
externalRepoAddress="no"
setupGitIgnore="no"
addSiteToHomesteadConfig="no"
localEvironment="no"
machineName="homestead"

#if no project name is specified, composer will use the default project name "laravel"
while getopts "gihl:o:" flag
do
	case $flag in
		g)
			initializeGitRepo="yes"
		;;
		o)
			externalRepoAddress="yes"
			originRepoAddress=$OPTARG
		;;
		i)
			setupGitIgnore="yes"
		;;
		h)
			addSiteToHomesteadConfig="yes"
		;;
		l)
			localEvironment="yes"
			if [ "$OPTARG" != "" ]; then
				machineName=$OPTARG
			fi
		;;
	esac
done
projectName=$1

#create the new project with composer
echo "Initializating the project via Composer"
composer create-project laravel/laravel $projectName

cd "$projectName"

#configure permissions on folder
echo "Granting write permissions to app/storage"
chmod -R 0777 app/storage

#setup a local environment?
if [ "$localEvironment" == "yes" ] || [ "$localEvironment" == "y" ]; then
	echo "Setting up Laravel local environment"
    if ([ "$localMachineName" != "homestead" ] && [ "$localMachineName" != "" ]); then
        find bootstrap -name 'start.php' -exec sed -i '' -e 's/homestead/'"$localMachineName"'/g' {} \;
        echo "Local environment name set to $localMachineName"
    fi
fi

#git initialization
if [ "$initializeGitRepo" == "yes" ] || [ "$initializeGitRepo" == "y" ]; then
    git init
	echo "Git repository initialized in the project root"
    #add external repository for the project (like bitbucket or github)?
    if [ "$externalRepoAddress" == "yes" ] || [ "$externalRepoAddress" == "y" ]; then
        git remote add origin "$originRepoAddress"
		echo "Added remote repository origin: $originRepoAddress"
    fi
    #.gitignore autodownload from github download .gitingnore from here:
    if [ "$setupGitIgnore" == "yes" ] || [ "$setupGitIgnore" == "y" ]; then
		echo "Downloading the .gitignore from the official Laravel repository"
		curl -o .gitignore https://raw.githubusercontent.com/laravel/laravel/master/.gitignore;
		echo ".gitignore added in your project root"
    fi
fi

#setup homestead machine for the new site
if [ "$addSiteToHomesteadConfig" == "yes" ] || [ "$addSiteToHomesteadConfig" == "y" ]; then
    #TODO: i can read also the configuration to get the root path and add the one of the project...

    #ask for the path to your homestead Folder...
    echo "Enter the location of your Homestead root folder: [default: ../../]"
    echo "Just the path to the folder do not enter the folder name (Homestead)"
    read homesteadRootPath;
    if [ "$homesteadRootPath" == "" ]; then
        homesteadRootPath="../../"
    fi

    #ask for the local address to use
    echo "Enter the loca address to use (i.e.: example.loc): "
    read mapLocalAddress;

    #ask for the vagrant path to map this local address
    echo "Enter the path that has to be mapped to this address: "
    read toPath;

    #this add the site to the conf, it can be done in a more elegant way, but this works...
    cd "$homesteadRootPath"/Homestead
    mv Homestead.yaml homestead.bk
    sed '/^'sites'/,/^[{space,tab}]*$/{  # [{space,tab}]
    /'sites:'/ {
            a\
            \    - map: "$mapLocalAddress
            a\
            \      to: "$toPath"
        }
    }' <homestead.bk > Homestead.yaml
    rm homestead.bk
    echo "Site added to the Homestead configuration"

    #add the local address to the /etc/hosts file
    sudo -- sh -c "echo 127.0.0.1   $mapLocalAddress >> /etc/hosts";
    echo "/etc/hosts updated with $mapLocalAddress"
else
    echo "No Homestead site setup";
fi

echo "Done. What are you waiting for...start working!"










