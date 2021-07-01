# Node

## environment

    NODE_ENV=production
    NODE_ENV=development

# npm

## proxy

at .npmrc

    proxy=http://user:password@proxy-url:8080

set globally

    npm set http http://user:password@proxy-url:8080

## Download module using curl /republish in another repository

    PACKAGE="rimraf"
    VERSION="2.2.6"

    curl -o ${PACKAGE}-${VERSION}.tgz http://registry.npmjs.org/${PACKAGE}/-/${PACKAGE}-${VERSION}.tgz

    # if the module has prepublish, need to be:
    # extracted, installed & publish
    tar xvzf ${PACKAGE}-${VERSION} # optional
    cd package
    npm i
    npm publish .

    # but if it's a simple module you can publish the tar directly
    npm publish ${PACKAGE}-${VERSION}.tgz

## Update angular in our artifactory

```bash
cd /tmp
REGISTRY=http://
VERSION=5.2.0
for PACKAGE in "animations" "common" "compiler" "core" "forms" "http" "platform-browser" "platform-browser-dynamic" "router" "compiler-cli" "platform-server"; do
  echo $PACKAGE

  curl -o "${PACKAGE}-${VERSION}.tgz" "http://registry.npmjs.org/@angular/${PACKAGE}/-/@angular/${PACKAGE}-${VERSION}.tgz"

  npm publish "${PACKAGE}-${VERSION}.tgz" --registry ${REGISTRY}
done

VERSION=2.4.2
PACKAGE=typescript

curl -o "${PACKAGE}-${VERSION}.tgz" "http://registry.npmjs.org/${PACKAGE}/-/${PACKAGE}-${VERSION}.tgz"
npm publish "${PACKAGE}-${VERSION}.tgz" --registry ${REGISTRY}

VERSION=5.5.6
PACKAGE=rxjs

curl -o "${PACKAGE}-${VERSION}.tgz" "http://registry.npmjs.org/${PACKAGE}/-/${PACKAGE}-${VERSION}.tgz"
npm publish "${PACKAGE}-${VERSION}.tgz" --registry ${REGISTRY}

```

## Install modules without symlinks

This happens to be useful when you are inside virtualbox/vagrant and don't have admin priviledges

    npm i --no-bin-links
