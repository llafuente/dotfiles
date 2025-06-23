# Go - crash course

Just syntax and ways to do things.

Meant to developer (from other languages) migration guide.

# playground

https://play.golang.org/


# Proxy

*Insecure proxy*. Go do not allow to send credentials to insecure proxies.

A
```
set http_proxy=http://127.0.0.1:8999
set https_proxy=http://127.0.0.1:8999
```

B
```
set GOPROXY=http://127.0.0.1:8999
```

# Compile

```cmd
go mod tidy # optional
go mod download

go build main.go

# cross-compile with version at given arch
cross-env GOARCH=386 go build -ldflags "-X main.Version=x.y.z" main.go
```

# Var declaration

```go
var filterEXE string = ""
filterEXE := ""
```

# maps / objects / dictionaries

## type / declaration

```go
// syntax
x map[key_type]value_type = {}

x map[string]string = {
  "xxx": "yyy",
}
y map[string]int = {
  "xxx": 999,
  "yyy": 888,
}

# uninitialized
var client http.Client{}

```
## send empty

```go
xxx(map[string]string{})
```

## array

### update array inside loop
````go
for i, v := range arr {
    arr[i] += 1 // or any other operation like append :P
}
````

## loop

```go
  for key, value := range headers {
    req.Header.Add(key, value)
  }
```

map[string]string{}

# variadic

```go
// declare variadic
func xxx(arg ...string) (string, error) {
  // loop variadic
  for _, v := range arg {
    fmt.Printf(" " + v)
  }

  // send variadic
  yyy(arg...)
}

// call variadic
xxx("x", "y", "z")

params := []string{"x", "y", "z"}
xxx(params)
```

# error handling

```go
if err := x(); err != nil {
  panic(err)
}
```

## recover from panic and return a value

```go
func main() {
    fmt.Println("Returned:", MyFunc())
}

func MyFunc() (ret string) {
    defer func() {
        if r := recover(); r != nil {
            ret = fmt.Sprintf("was panic, recovered value: %v", r)
        }
    }()
    panic("test")
    return "Normal Return Value"
}
```

# pointers

```go
type Project struct {
  Id string
}

var project *Project

project = &Project{
  Id: "xxx",
}
```

# read json file

```go
import (
  "io/ioutil"
  "encoding/json"
  "errors"
)

type RDAJSON struct {
  Project         RDAJSONProject            `json:"project"`
}

func ReadRDAJSON(rdaJSONPath string) (*RDAJSON, error) {
  payload, err := ioutil.ReadFile(rdaJSONPath)
  if err != nil {
    return nil, err
  }

  var rdajson *RDAJSON
  err = json.Unmarshal(payload, &rdajson)
  if err != nil {
    return nil, errors.New("Invalid JSON file: " + rdaJSONPath + "\nOriginal error: " + err.Error())
  }

  return rdajson, nil
}
```

# cross compilation

* https://www.digitalocean.com/community/tutorials/how-to-build-go-executables-for-multiple-platforms-on-ubuntu-16-04
