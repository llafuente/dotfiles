# Node

## environment

    NODE_ENV=production
    NODE_ENV=development

# npm

## proxy

at .npmrc

    proxy=http://user:password@proxy-url:8080

## Download module using curl

    curl -o ejs-2.5.6.tgz http://registry.npmjs.org/ejs/-/ejs-2.5.6.tgz
    
## Install modules without symlinks

This happens to be useful when you are inside virtualbox/vagrant and don't have admin priviledges

    npm i --no-bin-links
