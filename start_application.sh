
sudo service redis-server start
sudo service mysql start
# # 3. Setup environment to run testcode
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
