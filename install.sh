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

#export NVM_DIR="$HOME/.nvm"

#if [ -d "$NVM_DIR" ]; then
#  echo "✘ nvm path already exists / failed to add"
#else
#  echo "✓ nvm path exported"
#fi
echo "★★★★★ STAGE 1 completed ★★★★★"

# second script / second stage
echo " "
echo "★ Installing node..."
echo " "
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 18.1.0
if nvm use 18.1.0 ; then # installig nodejs 18.1.0
  echo "✓ nodejs 18 successfully installed"
else
  echo "✘ nodejs installation failed / node already installed"
fi

echo " "
echo "★ Installing yarn..."
echo " "
if curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 1.19.1 ; then
  echo "✓ curling yarn success"
else 
  echo "✘ curling yarn failed"
fi
echo " "
echo "★ Setting path for yarn..."
echo " "
#if  export PATH="$PATH:`yarn global bin`" >> ~/.bashrc ; then
#  echo "✓ yarn path setted successfully"
#else 
#  echo "✘ yarn path failed to set"
#fi
if grep -q "export PATH=\"\$PATH:\`yarn global bin\`\"" "$HOME/.bashrc"; then
    echo "The line is already in ~/.bashrc. No changes made."
else
    # If not found, append the line to ~/.bashrc
    echo 'export PATH="$PATH:`yarn global bin`"' >> "$HOME/.bashrc"
    echo "Line added to ~/.bashrc."
    echo "✓ yarn path setted successfully"
fi


# Cloning and installation of canvas lms

# creating canvas dir
echo " "
echo "★ Creating canvas lms dir"
echo " "
if sudo mkdir -p /var/canvas ; then
  echo "✓ canvas dir has been created"
else
  echo "✘ failed to create canvas dir / permission error"
fi
echo " "
echo "★ Giving access rights to the user"
echo " "
if sudo chown -R $USER /var/canvas ; then
  echo "✓ successfully given access rights to /var/canvas dir"
else
  echo "✘ failed to give access rights to /var/canvas dir"
fi
# cloning to github
echo " "
echo "★ Cloning into github"
echo " "
if sudo git clone https://github.com/instructure/canvas-lms.git /var/canvas; then 
  echo "✓ cloned successfully "
else 
  echo "✘ cloning failed / directory already exists "
fi

# switching to canvas dir
echo " "
echo "★ Switching to canvas directory..."
echo " "
if cd /var/canvas; then 
  echo "✓ switched successfully to the canvas directory"
else
  echo "✘ switching to canvas directory failed"
fi

# adding safe directory
echo " "
echo "★ Adding safe dir /var/canvas"
echo " "
if git config --global --add safe.directory /var/canvas ; then 
  echo "✓ successfully added safe dir"
else
  echo "✘ failed to add canvas as safe dir"
fi
echo " "
echo "★ Switching branch"
echo " "
if git checkout prod; then 
  echo "✓ switched to prod branch successfully"
else 
  echo "✘ switching to prod branch failed"
fi
echo " "
echo "★ Giving permissions"
echo " "
if sudo chmod 777 /var/canvas/* ; then 
  echo "✓ successfully given the permissions to dir"
else
  echo "✘ failed to given permission to dir"
fi
echo " "
echo "★ Editing config file..."
echo " "
for config in amazon_s3 database delayed_jobs domain file_store outgoing_mail security external_migration; do 
  cp config/$config.yml.example config/$config.yml
done 
echo "✓ completed editing file"
echo " "
echo "★★★★★ STAGE 2 completed ★★★★★"