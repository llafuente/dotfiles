# Documentation

https://www.autohotkey.com/docs/KeyList.htm

https://project-awesome.org/ahkscript/awesome-AutoHotkey#clipboard

# Arrays

```autohotkey
x := []
msgbox % x.MaxIndex() ; ""
msgbox % x.Length() ; 0
x.Push(1)
msgbox % x.MaxIndex() ; 1
msgbox % x.Length() ; 1
```

# Strings

```autohotkey
x := "xxx"
x =
(
multiline
)
```

# structs

```autohotkey
File := "C:\test.txt"
StructLen := 12 + StrLen( File ) + 1
VarSetCapacity( ParamStruct, StructLen, 0 )
NumPut( StructLen, ParamStruct, 0, "Int"  )
NumPut(  2, ParamStruct, 4, "UInt" )
StrPut( File, &ParamStruct+12 )

;DllCall("dllfile.dll\SetDefaultParams" ,"uint", &ParamStruct)

; A function pair to read/write strings from/to memory address.

StrPut( Str, @ ) {
Return DllCall( "RtlMoveMemory", UInt,@, UInt,&Str, UInt,StrLen(Str) )
}

StrGet( @ ) {
Return DllCall( "MulDiv", int,@, int,1, int,1, "Str" )
}
```

```
    VarSetCapacity(myStruct,60,0)
    numput(60,myStruct,0,"Uint") ; this dll function requires this to be set
    numput(1,myStruct,8,"Uint") ; SchemeLength

    DllCall("Winhttp.dll\WinHttpCrackUrl","PTR",&url,"UInt",StrLen(url),"UInt",0,"PTR",&myStruct)

    scheme := StrGet(NumGet(myStruct,4,"Ptr"),NumGet(myStruct,8,"UInt"))
    port := NumGet(myStruct,24,"Int")

```


Windows types
```
BOOL uint INT
HRESULT ptr INT
LANGID short USHORT
LPCSTR ptr ASTR
LPCTSTR ptr STR
LPCWSTR ptr WSTR
LPSTR ptr ASTR
LPTSTR ptr STR
LPWSTR ptr WSTR
LRESULT ptr UINT
PCSTR ptr ASTR
PCTSTR ptr STR
PCWSTR ptr WSTR
PSTR ptr ASTR
PTSTR ptr STR
PWSTR ptr WSTR
WCHAR short USHORT
```

more: https://www.autohotkey.com/boards/viewtopic.php?t=30497
