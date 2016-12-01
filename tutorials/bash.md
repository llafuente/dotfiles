# Bash utils

## Remove broken links

    symlinks -dr <path> # sudo apt-get install symlinks
    # or
    find . -xtype l -delete

## Redirects stderr to stdout

    2>&1

# sed replace raw sting (literal)

Escape a string literal for use as the replacement string

    search="text"
    search_literal=$(sed 's/[^^]/[&]/g; s/\^/\\^/g' <<< "$search")

Sed itself

    replace="replaceme"
    sed -i "s/${search_literal}/${replace}/g" file

Credits and more: http://stackoverflow.com/questions/29613304/is-it-possible-to-escape-regex-metacharacters-reliably-with-sed
