from fsphinx import *
from cloudmining import CloudMiningApp

app = CloudMiningApp()
cl = FSphinxClient.FromConfig('cloudmining/sphinx_client.py')
app.set_fsphinx_client(cl)
app.run()
