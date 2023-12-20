################################################################################
# Organization : Tarcin Robotic LLP
# Author       : vigneshpandian
################################################################################
#!/bin/bash
# declaration of variables for location storage
echo "################################################################################"
echo "# Organization : Tarcin Robotic LLP"
echo "# Author       : vigneshpandian"
echo "################################################################################"
echo " "

# declarations of locations
current_user=$(whoami); 
new_directory="/var"; 


# updating server 
echo    "---- UPDATING SERVER ----"
echo    " "
if sudo apt update && sudo apt upgrade -y ; then
    echo "---- updation completed !!! ----"
else
    echo "---- server updation failed ----"
fi

# postgres area
echo " "
echo "★ Create a PostgreSQL user and databases for Canvas"
echo " "
#installing postgresql
echo "---- installing postgresql ---- "
echo " "
if sudo apt-get install postgresql; then
    echo " ✓ postgresql installed successfully ✓"
else
    echo " ✘ postgres installation failed ✘ "
fi

# creating canvas user
echo " "
echo "★ Creating canvas user in postgresql"
echo " "
if sudo -u postgres createuser canvas --no-createdb --no-superuser --no-createrole --pwprompt; then
    echo "✓ successfully created canvas user"
else
    echo "✘ failed in creating canvas user"
fi

# creating canvas_production db
echo " "
echo "★ Creating canvas_production database"
echo " "
if sudo -u postgres createdb canvas_production --owner=canvas ; then 
    echo "✓ successfully created canvas_production database"
else
    echo "✘ failed in creating canvas_production database"
fi

# creating canvas_dev database 
echo " "
echo "★ Creating canvas_development database"
echo " "
if sudo -u postgres createdb canvas_development --owner=canvas; then
    echo "✓ successfully created canvas_development database"
else
    echo "✘ failed in creating canvas_development database"
fi

# creating postgres user for $USER
echo " "
echo "★ Creating postgres for user $USER "
echo " "
if sudo -u postgres createuser $USER; then 
    echo "✓ successfully created postgres user"
else    
    echo "✘ failed in creating postgres user"
fi

# altering user in postgresql with superuser
echo " "
echo "★ Altering user in postgresql with superuser"
echo " "
if sudo -u postgres psql -c "alter user $USER with superuser" postgres; then
    echo "✓ successfully altered $USER with superuser"
else
    echo "✘ failed in altering $USER with superuser"
fi

# Installing Git, Ruby, Node.js, and Yarn
echo " "
echo "★ installing additional packages "
echo " "

echo "★ adding ruby repo "
if sudo add-apt-repository ppa:instructure/ruby; then 
    echo "✓ ruby repo added successfully"
else
    echo "✘ failed to add ruby repo"
fi

# updating list
echo " "
echo "★ updating apt list"
if sudo apt-get update; then 
    echo "✓ list updated successfully"
else
    echo "✘ failed to update list"
fi

# installing additional packages
echo " "
if sudo apt-get install -y ruby3.1 ruby3.1-dev zlib1g-dev libxml2-dev libsqlite3-dev git-core git software-properties-common postgresql libpq-dev libxmlsec1-dev libidn11-dev curl make g++; then
    echo "✓ additional packages has been installed"
else
    echo "✘ failed to installed additional packages"
fi

# installing nvm
echo " "
echo "★ cloning nvm from github"

if git clone https://github.com/nvm-sh/nvm.git; then
    echo "✓ nvm downloaded "
else
    echo "✘ failed to downoad nvm"
fi

cd nvm  # changing dir to nvm
echo " "
if ./install.sh ; then  # instaling nvm 
    echo "✓ nvm installed successfully"
else
    echo "✘ failed to install nvm"
fi

cd  # changing to default directory

echo "★ sourcing...."
if source ~/.bashrc; then 
    echo "✓ sourcing completed "
else 
    echo "✘ sourcing failed"
fi

export NVM_DIR="$HOME/.nvm"

if [ -d "$NVM_DIR" ]; then
  echo "✘ nvm path already exists / failed to add"
else
  echo "✓ nvm path exported"
fi




