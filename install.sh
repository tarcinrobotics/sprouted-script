################################################################################
# Organization : Tarcin Robotic LLP
# Author       : vigneshpandian
################################################################################
#!/bin/bash
# declaration of variables for location storage

sudo apt-get install postgresql-12;
sudo -u postgres createuser canvas --no-createdb --no-superuser --no-createrole --pwprompt; 
sudo -u postgres createdb canvas_production --owner=canvas; 
sudo -u postgres createdb canvas_development --owner=canvas; 
sudo -u postgres createuser $USER;
sudo -u postgres psql -c "alter user $USER with superuser" postgres;
