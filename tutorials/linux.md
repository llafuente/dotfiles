# environment variable

## global / persists

edit one: `/etc/environment` or `/etc/profile`

## user / persists

edit one: `$HOME/.bashrc` or `$HOME/~/.bash_profile` or `~/.bash_login` or
`~/.profile`

## user session

VAR=VALUE # this is enough for the session
export VAR=VALUE # this is need for export from script

setenv VAR "VALUE" # tcsh


## working with proxies

    # many command will search for http_proxy ENV_VAR
    http_proxy=${PROXY}

    npm i xxx --registry https://registry.npmjs.org/ --proxy ${PROXY}

    curl --proxy ${PROXY} http://
    python get-pip.py --proxy=${PROXY}
    pip install pre-commit --proxy ${PROXY}
