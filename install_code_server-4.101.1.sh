#!/bin/bash
#SBATCH -N 1
#SBATCH -n 4
#SBATCH -p short

# Setting up the environment
source env_code_server-4.101.1.sh

# Creating the src directory for the installed application
mkdir -p $SOFTWARE_DIRECTORY/src

# Installing $SOFTWARE_NAME/$SOFTWARE_VERSION
cd $SOFTWARE_DIRECTORY/src
wget https://github.com/coder/code-server/releases/download/v4.101.1/code-server-4.101.1-linux-amd64.tar.gz
tar -xvf code-server-4.101.1-linux-amd64.tar.gz
mv code-server-4.101.1-linux-amd64/ ../

export SOFTWARE_DIRECTORY=$SOFTWARE_DIRECTORY/code-server-4.101.1-linux-amd64

# Creating modulefile
touch $SOFTWARE_VERSION
echo "#%Module" >> $SOFTWARE_VERSION
echo "module-whatis	 \"Loads $SOFTWARE_NAME/$SOFTWARE_VERSION module." >> $SOFTWARE_VERSION
echo "" >> $SOFTWARE_VERSION
echo "This module was build on $(date)" >> $SOFTWARE_VERSION
echo "" >> $SOFTWARE_VERSION
echo "Code Server (https://github.com/coder/code-server) provides VSCode in a browser environment" >> $SOFTWARE_VERSION
echo "" >> $SOFTWARE_VERSION
echo "The script used to build this module can be found here: $GITHUB_URL" >> $SOFTWARE_VERSION
echo "" >> $SOFTWARE_VERSION
echo "To load the module, type:" >> $SOFTWARE_VERSION
echo "module load $SOFTWARE_NAME/$SOFTWARE_VERSION" >> $SOFTWARE_VERSION
echo "\"" >> $SOFTWARE_VERSION
echo "" >> $SOFTWARE_VERSION
echo "conflict	 $SOFTWARE_NAME" >> $SOFTWARE_VERSION
echo "prepend-path	 PATH $SOFTWARE_DIRECTORY/bin" >> $SOFTWARE_VERSION
echo "prepend-path	 LD_LIBRARY_PATH $SOFTWARE_DIRECTORY/lib" >> $SOFTWARE_VERSION
echo "prepend-path	 LIBRARY_PATH $SOFTWARE_DIRECTORY/lib" >> $SOFTWARE_VERSION

# Moving modulefile
mkdir -p $CLUSTER_DIRECTORY/modulefiles/$SOFTWARE_NAME
cp $SOFTWARE_VERSION $CLUSTER_DIRECTORY/modulefiles/$SOFTWARE_NAME/$SOFTWARE_VERSION
