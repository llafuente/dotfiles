# Bash utils

This is just a collection of small scripts

## List broken links

    find . -type l ! -exec test -e {} \; -print

## Remove broken links

    symlinks -dr <path> # sudo apt-get install symlinks
    # or
    find . -xtype l -delete

## Redirects stderr to stdout

    2>&1

## sed replace raw sting (literal)

Escape a string literal for use as the replacement string

    search="text"
    search_literal=$(sed 's/[^^]/[&]/g; s/\^/\\^/g' <<< "$search")

Sed itself

    replace="replaceme"
    sed -i "s/${search_literal}/${replace}/g" file

Credits and more: http://stackoverflow.com/questions/29613304/is-it-possible-to-escape-regex-metacharacters-reliably-with-sed


## Split by

    string="a,b,c"
    split=$(echo ${string} | tr "," "\n"); # split by ,
    for i in ${split}
    do
      echo ${i}
    done

alternative method

    string="a|b|c"
    split=(${string//|/ })
    for i in ${split[@]}
    do
      echo ${i}
    done


## ssh login with username & password


    USERNAME=""
    SERVER_IP=""
    PASSWORD=""

    cat <<DELIM | tee ssh.expect | grep -v ""
    #!/usr/bin/expect -f
    set timeout -1
    spawn ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking no" -o "ConnectTimeout=120"     ${USERNAME}@${SERVER_IP} "echo OK; exit;"
    expect {
      password: {
        send "${PASSWORD}\\r"; #maybe \\n
        exp_continue;
      }
      eof;
    }

    DELIM

    expect ./ssh.expect

## scp login with username & password

    USERNAME=""
    SERVER_IP=""
    PASSWORD=""
    SRC_FILE=""
    DST_FILE=""

    cat <<DELIM | tee scp.expect | grep -v ""
    #!/usr/bin/expect -f
    set timeout -1 #maybe: set timeout 3600
    spawn scp -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking no" -o "ConnectTimeout=120" ${SRC_FILE} ${USERNAME}@${SERVER_IP}:${DST_FILE}
    expect {
      password: {
        send "${PASSWORD}\\r"; #maybe \\n
        exp_continue;
      }
      eof;
    }

    DELIM

    expect ./scp.expect

## Profiling

    START_DATE=$(date +%s%N)
    END_DATE=$(date +%s%N)
    echo "time(ms): $(((END_DATE - START_DATE) / 1000))"

## If / test

* -e: Returns true value if file exists.
* -f: Return true value if file exists and regular file.
* -r: Return true value if file exists and is readable.
* -w: Return true value if file exists and is writable.
* -x: Return true value if file exists and is executable.
* -d: Return true value if exists and is a directory.


oneliner (~ternary)

    [[ -f /xxx ]] && echo "File exist" || echo "File does not exist"
