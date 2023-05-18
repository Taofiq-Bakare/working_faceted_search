#!/bin/sh

echo "############################################"
echo "#     Installing Dependencies		 #"
echo "############################################"
sudo apt-get -qq update -y
sudo apt-get -qq upgrade -y
sudo apt-get install dos2unix
sudo apt-get -qq install build-essential -y
sudo apt-get -qq install redis-server -y
# sudo apt-get -qq install  mysql-server -y  # Silent Install
sudo apt-get install mysql-server
sudo service mysql start
sudo mysql_secure_installation

sudo mysql -u root -p <<MYSQL_SCRIPT
CREATE DATABASE fsphinx;
CREATE USER 'fsphinx'@'localhost' IDENTIFIED BY 'fsphinx';
GRANT ALL PRIVILEGES ON fsphinx.* TO 'fsphinx'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT



2. Load sample data
sudo mysql -ufsphinx -pfsphinx -Dfsphinx < ./fSphinx/tutorial/sql/imdb_top400.data.sql

sudo apt-get -qq install sphinxsearch -y
sudo apt install nano
sudo apt-get install software-properties-common
sudo locale-gen en_US.UTF-8
sudo update-locale LANG=en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8




# Install Python Modules
echo
echo "############################################"
echo "#     Installing Python Dependencies       #"
echo "############################################"
sudo apt-get install -y python-setuptools python-webpy python-dev python-simplejson python-scipy
sudo apt-get install -y python-mysqldb python-redis

# Download sources
echo
echo "##########################"
echo "## DOWNLOADING TARS ... ##"
echo "##########################"
wget https://github.com/alexksikes/fSphinx/tarball/master -O fSphinx_
wget https://github.com/alexksikes/cloudmining/tarball/master -O cloudmining_
wget https://github.com/alexksikes/SimSearch/tarball/master -O SimSearch_
wget https://github.com/jsocol/sphinxapi/tarball/master -O sphinxapi_
wget https://github.com/alexksikes/mass-scraping/tarball/master -O mass-scraping_
dos2unix install.sh start_application.sh

# Create Dirs
mkdir fSphinx cloudmining SimSearch sphinxapi mass-scraping
echo
echo "###################"
echo "## EXTRACTING... ##"
echo "###################"
echo
echo "## (1/5) Extracting fSphinx... ##"
tar xzf fSphinx_ -C fSphinx --strip-components=1
echo "## (2/5) Extracting cloudmining... ##"
tar xzf cloudmining_ -C cloudmining --strip-components=1
echo "## (3/5) Extracting SimSearch... ##"
tar xzf SimSearch_ -C SimSearch --strip-components=1
echo "## (4/5) Extracting sphinxapi... ##"
tar xzf sphinxapi_ -C sphinxapi --strip-components=1
echo "## (5/5) Extracting mass-scraping ##"
tar xzf mass-scraping_ -C mass-scraping --strip-components=1

echo
echo "##############################"
echo "## REMOVING DOWNLOADED TARS ##"
echo "##############################"
rm -f $PWD/fSphinx_ $PWD/cloudmining_ $PWD/SimSearch_ $PWD/sphinxapi_ $PWD/mass-scraping_

# Install...
echo
echo "## Installing fSphinx ##"
cd ./fSphinx
sudo python setup.py -q install
echo "## Installing SimSearch ##"
cd .././SimSearch
sudo python setup.py -q install
echo "## Installing sphinxapi ##"
cd .././sphinxapi
sudo python setup.py -q install
cd ../

# Remove Dirs
#rm -f $PWD/fSphinx $PWD/SimSearch $PWD/sphinxapi

# Configure
# 1. Create mysql account for fsphinx

# sudo mysql -u root -p <<MYSQL_SCRIPT
# CREATE DATABASE fsphinx;
# CREATE USER 'fsphinx'@'localhost' IDENTIFIED BY 'fsphinx';
# GRANT ALL PRIVILEGES ON fsphinx.* TO 'fsphinx'@'localhost';
# FLUSH PRIVILEGES;
# MYSQL_SCRIPT



# 2. Load sample data
# sudo mysql -ufsphinx -pfsphinx -Dfsphinx < ./fSphinx/tutorial/sql/imdb_top400.data.sql
sudo service redis-server start
sudo service mysql start
# 3. Setup environment to run testcode
cd ./fSphinx/tutorial/
sudo indexer -c ./config/sphinx_indexer.cfg --all
sudo searchd -c ./config/sphinx_indexer.cfg

cp ./config/sphinx_client.py ../../cloudmining/.

cd ../../cloudmining
file="application.py"
[[ -f "$file" ]] && rm -f "$file"
cat <<EOT >> $file
from fsphinx import *
from cloudmining import CloudMiningApp

app = CloudMiningApp()
cl = FSphinxClient.FromConfig('sphinx_client.py')
app.set_fsphinx_client(cl)
app.run()
EOT

echo
echo  "#### DONE ###"
echo

python application.py



