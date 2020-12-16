# Documentation

https://www.autohotkey.com/docs/KeyList.htm

# Arrays

```autohotkey
x := []
msgbox % x.MaxIndex() ; ""
x.Push(1)
msgbox % x.MaxIndex() ; 1
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
