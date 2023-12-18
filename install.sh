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

echo " adding ruby repo "
if sudo add-apt-repository ppa:instructure/ruby; then 
    echo "ruby repo added successfully"
else
    echo "failed to add ruby repo"
fi

# updating list
echo " updating apt list"
if sudo apt-get update; then 
    echo " list updated successfully"
else
    echo " failed to update list"
fi

# installing additional packages
if sudo apt-get install -y ruby3.1 ruby3.1-dev zlib1g-dev libxml2-dev libsqlite3-dev git-core git software-properties-common postgresql libpq-dev libxmlsec1-dev libidn11-dev curl make g++; then
    echo " additional packages has been installed"
else
    echo " failed to installed additional packages"
fi

# installing nvm
echo " nvm"

if curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash; then
    echo " curl nvm finished "
else
    echo " curl nvm failed / already exists"
fi

echo " sourcing...."
if source ~/.bashrc; then 
    echo " sourcing completed "
else 
    echo " sourcing failed"
fi

echo " installing node..."

if nvm install 18.1.0; then 
    echo "nvm successfully installed"
else
    echo "nvm installation failed"
fi

echo " installing yarn..."
if curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 1.19.1; then
    echo " curling yarn success "
else 
    echo " curling yarn failed "
fi

echo " setting path for yarn..."
if export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH" ; then
    echo " yarn path setted successfully"
else 
    echo " yarn path failed to set"
fi
