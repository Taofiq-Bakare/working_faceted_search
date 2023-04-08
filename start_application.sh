
sudo service redis-server start
sudo service mysql start
# # 3. Setup environment to run testcode
cd ./fSphinx/tutorial/
sudo indexer -c ./config/sphinx_indexer.cfg --all
sudo searchd -c ./config/sphinx_indexer.cfg

cp ./config/sphinx_client.py ../../cloudmining/.

cd ../../cloudmining


python application.py
