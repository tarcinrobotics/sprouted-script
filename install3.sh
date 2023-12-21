# declarations for file configuration
# configuring database, outgoing mail, domain settings
database_file="/var/canvas/config/database.yml"
dynamic_settings_file="/var/canvas/config/dynamic_settings.yml"
outgoing_mail_file="/var/canvas/config/outgoing_mail.yml"
security_file="/var/canvas/config/security.yml"
domain_file="/var/canvas/config/domain.yml"

# content
outgoing_mail_content='production:
  delivery_method: "smtp"
  address: "smtp.gmail.com"
  enable_starttls_auto: true
  port: "587"
  user_name: "tarcinrobotics301@gmail.com"
  password: "ryzjskxdibavwhbd"
  authentication: "plain" # plain, login, or cram_md5
  domain: "localhost"
  outgoing_address: "tarcinrobotics301@gmail.com"
  default_name: "SproutED - Unlock the Tech, Unlock the World"'

domain_content='test:
  domain: localhost:3000

development:
  domain: "localhost:3001"
  # If you want to set up SSL and a separate files domain, use the following and set up puma-dev from github.com/puma/puma-dev
  # domain: "canvas-lms.test" # for puma-dev
  # files_domain: "canvas-lms.files" # for puma-dev
  # ssl: true

production:
  domain: localhost
  # whether this instance of canvas is served over ssl (https) or not
  # defaults to true for production, false for test/development
  ssl: true
  # files_domain: "canvasfiles.example.com"'

# copying database file 
if cp /var/canvas/config/database.yml.example /var/canvas/config/database.yml ; then
    echo "✓ successfully copied the database file"
else
    echo "✘ failed in copying the database file"
fi

# copying dynamic_settings file
if cp /var/canvas/config/dynamic_settings.yml.example /var/canvas/config/dynamic_settings.yml ; then
    echo "✓ successfully copied the dynamic_settings file"
else
    echo "✘ failed in copying the dynamic_settings file"
fi

# copying outgoing_mail file 
if cp /var/canvas/config/outgoing_mail.yml.example /var/canvas/config/outgoing_mail.yml ; then
    echo "✓ successfully copied the outgoing_mail file"
else
    echo "✘ failed in copying the outgoing_mail file"
fi

# editing config files

# databse.yml file

if sed -i 's/password: your_password/password: canvas/g' "$database_file" ; then    
    echo "✓ changed password to canvas to database.yml file"
else    
    echo "✘ failed in changing the password to database.yml file / the password has been already changed"
fi

# dynamic_settings.yml file
if sed -i 's/development/production/g' "$dynamic_settings_file" ; then  
    echo "✓ changed the dynamic_settings file"
else
    echo "✘ failed to change the dynamic_settings file / the file has been already changed"
fi

# outgoing_mail file
awk -v new_config="$outgoing_mail_content" '/production:/ {print new_config; found=1; next} found && /^\s*$/{found=0} !found' "$outgoing_mail_file" > "$outgoing_mail_file.tmp"
if mv "$outgoing_mail_file.tmp" "$outgoing_mail_file" ; then 
    echo "✓ outgoing_mail configured successfully"
else
    echo "✘ outgoing_mail failed to configure"
fi

# security file
#awk -v sec_config="$security_content" '/production:/ {print sec_config; found=1; next} found && /^\s*$/{found=0} !found' "$security_file" > "$security_file.tmp"
if sed -i '/production:/,/lti_iss:/{s/encryption_key: .*/encryption_key: daedd3a131ddd8988b14f6e4e01039c93cfa0160/}' $security_file ; then
    echo "✓ security file configured successfully"
else
    echo "✘ security file failed to configure"
fi

# domain file
if echo "$domain_content" > "$domain_file" ; then
    echo "✓ domain file configured successfully"
else
    echo "✘ domain file failed to configure"

echo "★★★★★ STAGE 3 completed ★★★★★"