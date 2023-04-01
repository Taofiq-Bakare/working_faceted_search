from fsphinx import *
from cloudmining import CloudMiningApp

app = CloudMiningApp()
cl = FSphinxClient.FromConfig('sphinx_client.py')
app.set_port(80)
app.set_fsphinx_client(cl)
app.run()
