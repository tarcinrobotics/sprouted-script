# second script
echo "Installing node..."

if nvm install 18.1.0; then 
  echo "✓ nvm successfully installed"
else
  echo "✘ nvm installation failed / node already installed"
fi

echo "Installing yarn..."
if curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 1.19.1 ; then
  echo "✓ curling yarn success"
else 
  echo "✘ curling yarn failed"
fi

echo "Setting path for yarn..."
if export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"; then
  echo "✓ yarn path setted successfully"
else 
  echo "✘ yarn path failed to set"
fi

# Cloning and installation of canvas lms

# creating canvas dir
if sudo mkdir -p /var/canvas ; then
  echo "✓ canvas dir has been created"
else
  echo "✘ failed to create canvas dir"
fi

if sudo chown -R $USER /var/canvas ; then
  echo "✓ successfully given access rights to /var/canvas dir"
else
  echo "✘ failed to give access rights to /var/canvas dir"
fi
# cloning to github
echo "Cloning into github"
if sudo git clone https://github.com/instructure/canvas-lms.git /var/canvas; then 
  echo "✓ cloned successfully "
else 
  echo "✘ cloning failed / directory already exists "
fi

# switching to canvas dir
echo "Switching to canvas directory..."
if cd /var/canvas; then 
  echo "✓ switched successfully to the canvas directory"
else
  echo "✘ switching to canvas directory failed"
fi

# adding safe directory
if git config --global --add safe.directory /var/canvas ; then 
  echo "✓ successfully added safe dir"
else
  echo "✘ failed to add canvas as safe dir"

echo "Switching branch"
if git checkout prod; then 
  echo "✓ switched to prod branch successfully"
else 
  echo "✘ switching to prod branch failed"
fi

echo "Editing config file..."
for config in amazon_s3 database delayed_jobs domain file_store outgoing_mail security external_migration; do 
  cp config/$config.yml.example config/$config.yml
done 
echo "✓ completed editing file"