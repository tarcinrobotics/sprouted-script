# second script
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
if export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"; then
  echo "✓ yarn path setted successfully"
else 
  echo "✘ yarn path failed to set"
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
echo "★ Editing config file..."
echo " "
for config in amazon_s3 database delayed_jobs domain file_store outgoing_mail security external_migration; do 
  cp config/$config.yml.example config/$config.yml
done 
echo "✓ completed editing file"
echo " "
echo "★★★★★ STAGE 2 completed ★★★★★"