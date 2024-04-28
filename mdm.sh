#!/bin/bash
sudo profiles show -type enrollment
sudo rm /var/db/ConfigurationProfiles/Settings/.cloudConfigHasActivationRecord
sudo rm /var/db/ConfigurationProfiles/Settings/.cloudConfigRecordFound
sudo touch /var/db/ConfigurationProfiles/Settings/.cloudConfigProfileInstalled
sudo touch /var/db/ConfigurationProfiles/Settings/.cloudConfigRecordNotFound
if [ -d "/Volumes/Macintosh HD - Data" ]; then
    diskutil rename "Macintosh HD - Data" "Data"
fi
echo -e "Create realname (default is Macbook): "
read realName
realName="${realName:=Macbook}"
echo -e "Create username (default is macbook): "
read username
username="${username:=macbook}"
echo -e "Create password (default 1234): "
read passw
passw="${passw:=1234}"
dscl_path='/Volumes/Data/private/var/db/dslocal/nodes/Default'
dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username"
dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" UserShell "/bin/zsh"
dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" RealName "$realName"
dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" RealName "$realName"
dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" UniqueID "501"
dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" PrimaryGroupID "20"
mkdir "/Volumes/Data/Users/$username"
dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" NFSHomeDirectory "/Users/$username"
dscl -f "$dscl_path" localhost -passwd "/Local/Default/Users/$username" "$passw"
dscl -f "$dscl_path" localhost -append "/Local/Default/Groups/admin" GroupMembership $username
echo "0.0.0.0 deviceenrollment.apple.com" >>/Volumes/Macintosh\ HD/etc/hosts
echo "0.0.0.0 mdmenrollment.apple.com" >>/Volumes/Macintosh\ HD/etc/hosts
echo "0.0.0.0 iprofiles.apple.com" >>/Volumes/Macintosh\ HD/etc/hosts
touch /Volumes/Data/private/var/db/.AppleSetupDone
rm -rf /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigHasActivationRecord
rm -rf /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordFound
touch /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigProfileInstalled
touch /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordNotFound
echo "Done!"
echo "Please reboot!"