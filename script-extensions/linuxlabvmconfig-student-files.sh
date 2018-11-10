export DEBIAN_FRONTEND=noninteractive
DOWNLOADURL=$1
#Install LXDE lxde.org and xrdp - (make sure to open 3389 on the NSG of the azure vm)
apt-get update
apt-get install lxde -y
apt-get install xrdp -y
/etc/init.d/xrdp start

#Prepare XWindows System
sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config
wget https://opsgilityweb.blob.core.windows.net/test/xsession
mv xsession /home/demouser/.xsession

apt-get install zip unzip -y


if [ -z "${DOWNLOADURL}" ]; then
  echo "no download url for lab"
else
  echo "setting up student files"
  mkdir /usr/opsgilitytraining
  wget -P /usr/opsgilitytraining $DOWNLOADURL
  unzip /usr/opsgilitytraining/StudentFiles.zip -d /usr/opsgilitytraining
  chmod -R 775 /usr/opsgilitytraining
  chown -R demouser /usr/opsgilitytraining
fi
