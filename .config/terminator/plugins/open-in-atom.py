# Clickable Files by nofxx
# modified version by llafuente: find the realpath of the file & use atom
"""files.py - Clickable Files URIs open in Emacs"""
import re, os, subprocess, inspect
import terminatorlib.plugin as plugin

# Every plugin you want Terminator to load *must* be listed in 'AVAILABLE'
AVAILABLE = ['FileURLHandler']

class FileURLHandler(plugin.URLHandler):
    capabilities = ['url_handler']
    handler_name = 'file_path'

    # Match any non-space string starting with an alphanumericm or a slash
    # and ending with a colon followed by a number
    match = r'[a-zA-Z0-9\.\/][^ ]+:[[:digit:]]+|[a-zA-Z0-9\/][^ ]+\([[:digit:]]+\)'

    def callback(self, url):
        # Change file(N) to file:N
        url = re.sub('[\)]', '', re.sub('[\(]', ':', url))
        # Change file#N to file:N
        url = re.sub('[#]', ':', url)
        # Split result match file:line:col
        params = url.split(':')
        col = 0
        if len(params) == 3:
          fname, line, col = params
        else:
          fname, line = params

        # find the file
        p = subprocess.Popen(['find', '-name', fname], stdout=subprocess.PIPE,
            stderr=subprocess.PIPE)

        out, err = p.communicate()
        files = out.strip().split("\n")

        if len(files) > 1:
            print "Found many files... ignoring"
            return ""

        print files
        subprocess.call(["atom", files[0] + ":" + str(line) + ":" + str(col)])

        return ""
