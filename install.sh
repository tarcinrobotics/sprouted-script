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