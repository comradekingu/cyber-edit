if [ ! -d "build" ] 
then
    echo "You need to build before you can install. Check https://github.com/cyberos/cyber-edit for instructions." 
    exit 1
fi
sudo rm /usr/share/applications/cyber-edit.desktop
sudo rm /usr/bin/cyber-edit
sudo cp build/cyber-edit /usr/bin
sudo cp cyber-edit.desktop /usr/share/applications
