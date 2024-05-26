#!/bin/bash


ZIP_FILE=$1
USER=$2
GROUP=$3


# Create a new group and a new user with no home directory and no shell
sudo groupadd "$GROUP";
sudo useradd --no-create-home --shell /bin/false "$USER";

# Check if the file exists
if [ ! -f "$ZIP_FILE" ]; then
    echo "File not found!"
fi

# generate file type
ZIP_TYPE=$(file --mime-type -b "$ZIP_FILE")

# check file type to run other commands
if [ "$ZIP_TYPE" == "application/gzip" ]; then


# checking if directory to save extracted files exists before creating and extrating the files
if [ ! -f ${ZIP_FILE%%.*} ]; then
# extract files and directories from .tar.gz file and make new directory to copy all extracted files and directory
    tar -xzvf "$ZIP_FILE" -C "${ZIP_FILE%%.*}"
else
    mkdir ${ZIP_FILE%%.*}
fi

# change user and group of the newly created directory carrying all the extracted files and directories
    sudo chown -R "$USER":"$GROUP" ${ZIP_FILE%%.*}

# find all files in the extracted data to change the permissions of all of them
    sudo find ${ZIP_FILE%%.*}/ -type f -exec chmod 664 {} \;

# find all directories in the extracted data to change the permissions of all of them
    sudo find ${ZIP_FILE%%.*}/ -type d -exec chmod 775 {} \;

fi

echo ""
echo ""
echo ""
echo ""
echo "Completed!"

echo ""
echo ""
sudo tar -cf /tmp/fixed-archive.tar.gz ${ZIP_FILE%%.*}
echo "check '/tmp/' for 'fixed-archive.tar.gz' to see new archived data."

echo ""
echo ""