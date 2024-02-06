# python

# language

## return multiple values (tuple)

```
def fun():
    str = "str"
    x   = 20
    return str, x; # aka (str, x)

str, x = fun() # Assign returned tuple
print(str)
print(x)
```

## Objects / Dictionary

### key exists

```
if 'x' in obj:
```

### delete key

```
del self.headers["Content-Type"]
```

# PIP

## install specific version

```
pip install httplib2==0.19.1
```

## remove all pip modules

```
pip3 freeze > modules.txt
pip3 uninstall -r modules.txt -y
```

