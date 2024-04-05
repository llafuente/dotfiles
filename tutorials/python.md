# python

## pip

### Configure pip proxy

> pip config set global.proxy http://user:pwd@host:port

### list modules

> pip list

> pip freeze

### Install specific version

> pip install py2exe==0.10.4.1

### Remove all packages

> pip freeze | xargs pip uninstall -y
