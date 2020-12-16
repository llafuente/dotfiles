# verdaccio

## Install

    npm i -g verdaccio

    verdaccio

## Edit config

It's displayed at run

remove uplinks, we want 100% private repo

run again: `verdaccio`

## .npmrc

```
registry=http://localhost:4873
```
or `--registry=http://localhost:4873`

# config.yml

Remove: uplinks
remove: proxy: npmjs

## Create user


    npm login
    test
    test

## Publish

    npm publish .


## CI publish

### master

    npm publish .

### any other branch


    npm version prerelease --preid=<git-branch> --no-git-tag-version
    # el output va al siguiente comando
    npm unpublish <package.name>@<output-version>
    npm publish . --tag snapshot
