# Go - crash course

Just syntax and ways to do things.

Meant to developer (from other languages) migration guide.

# playground

https://play.golang.org/

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

# cross compilation

* https://www.digitalocean.com/community/tutorials/how-to-build-go-executables-for-multiple-platforms-on-ubuntu-16-04
