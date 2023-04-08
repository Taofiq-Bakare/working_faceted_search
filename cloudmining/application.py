from fsphinx import *
from cloudmining import CloudMiningApp

# app = CloudMiningApp()
# cl = FSphinxClient.FromConfig('sphinx_client.py')
# app.set_fsphinx_client(cl)
# app.run()


def main():
    app = CloudMiningApp()
    cl = FSphinxClient.FromConfig('sphinx_client.py')
    app.set_fsphinx_client(cl)
    app.run()

if __name__ == '__main__':
    main()