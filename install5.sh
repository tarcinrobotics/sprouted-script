sudo apt-get install apache2
sudo apt-get install -y dirmngr gnupg apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger focal main > /etc/apt/sources.list.d/passenger.list'
sudo apt-get update
sudo apt-get install -y libapache2-mod-passenger
sudo a2enmod rewrite
sudo a2enmod passenger
sudo a2enmod ssl
sudo nano /etc/apache2/mods-available/passenger.conf
add username in that file
sudo unlink /etc/apache2/sites-enabled/000-default.conf
sudo nano /etc/apache2/sites-available/canvas.conf

<VirtualHost *:80>
ServerName {your_domain}
DocumentRoot /var/canvas/public
PassengerRuby /usr/bin/ruby3.1
PassengerAppEnv production
RailsEnv production
<Directory /var/canvas/public>
AllowOverride all
Options -MultiViews
Require all granted
</Directory>
</VirtualHost>

sudo a2ensite canvas.conf
sudo ln -s /var/canvas/script/canvas_init /etc/init.d/canvas_init
sudo update-rc.d canvas_init defaults

sudo ufw allow 80
 sudo ufw allow 80/tcp
 sudo ufw allow 443
 sudo ufw allow 443/tcp
 sudo ufw allow 3001
 sudo ufw allow 3001/tcp
 sudo ufw reload

 sudo /etc/init.d/canvas_init start
