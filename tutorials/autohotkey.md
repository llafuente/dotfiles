# Documentation

https://www.autohotkey.com/docs/KeyList.htm

https://project-awesome.org/ahkscript/awesome-AutoHotkey#clipboard

# local, global, ?


```ahk
#Warn All, StdOut

xxx() {
  throw Exception("xxx")
}

e =: 1

step1() {
  try {
    xxx()
  } catch e {

  }
}


```


# Commands vs Functions

```ahk
StringLeft, OutputVar, InputVar, Count

NewString := LTrim(String , OmitChars)
```

```ahk
input := "xxx"
; output is a variable
; input is a variable
StringLeft, output, input, 2

; output is a variable
; input is a variable but it's an expression
StringLeft, output, % input, 2


; output is a variable
; input is a variable (indirection) with the value of input -> xxx
xxx := "yyy"
StringLeft, output, %input%, 2

; indirection don't work on some commands
arr_1 := 1
arr_2 := 2
arr_3 := 3

loop 3 {
  val := "arr_" . A_Index
  ival := %val%
  msgbox %val%
  msgbox %ival%
}

```



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

exampleString := (
    "`n" .
    "multiple`n" .
    "lines`n" .
    "of`n" .
    "string`n"
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

# C Types

https://www.autohotkey.com/board/topic/69139-class-dllstruct-ahk-11/

```
Type               32-bit / 64-bit
==================================
APIENTRY                        ; won't compile
ATOM                    2 / 2
BOOL                    4 / 4
BOOLEAN                 1 / 1
BYTE                    1 / 1
CALLBACK                        ; won't compile
CCHAR                   1 / 1
CHAR                    1 / 1
COLORREF                4 / 4
CONST                           ; won't compile
DWORD                   4 / 4
DWORD32                 4 / 4
DWORD64                 8 / 8
DWORDLONG               8 / 8
DWORD_PTR               4 / 8
FLOAT                   4 / 4
HACCEL                  4 / 8
HALF_PTR                2 / 4
HANDLE                  4 / 8
HBITMAP                 4 / 8
HBRUSH                  4 / 8
HCOLORSPACE             4 / 8
HCONV                   4 / 8
HCONVLIST               4 / 8
HCURSOR                 4 / 8
HDC                     4 / 8
HDDEDATA                4 / 8
HDESK                   4 / 8
HDROP                   4 / 8
HDWP                    4 / 8
HENHMETAFILE            4 / 8
HFILE                   4 / 4
HFONT                   4 / 8
HGDIOBJ                 4 / 8
HGLOBAL                 4 / 8
HHOOK                   4 / 8
HICON                   4 / 8
HINSTANCE               4 / 8
HKEY                    4 / 8
HKL                     4 / 8
HLOCAL                  4 / 8
HMENU                   4 / 8
HMETAFILE               4 / 8
HMODULE                 4 / 8
HMONITOR                4 / 8
HPALETTE                4 / 8
HPEN                    4 / 8
HRESULT                 4 / 4
HRGN                    4 / 8
HRSRC                   4 / 8
HSZ                     4 / 8
HWINSTA                 4 / 8
HWND                    4 / 8
INT                     4 / 4
INT16                   2 / 2
INT32                   4 / 4
INT64                   8 / 8
INT8                    1 / 1
INT_PTR                 4 / 8
LANGID                  2 / 2
LCID                    4 / 4
LCTYPE                  4 / 4
LGRPID                  4 / 4
LONG                    4 / 4
LONG32                  4 / 4
LONG64                  8 / 8
LONGLONG                8 / 8
LONG_PTR                4 / 8
LPARAM                  4 / 8
LPBOOL                  4 / 8
LPBYTE                  4 / 8
LPCOLORREF              4 / 8
LPCSTR                  4 / 8
LPCTSTR                 4 / 8
LPCVOID                 4 / 8
LPCWSTR                 4 / 8
LPDWORD                 4 / 8
LPHANDLE                4 / 8
LPINT                   4 / 8
LPLONG                  4 / 8
LPSTR                   4 / 8
LPTSTR                  4 / 8
LPVOID                  4 / 8
LPWORD                  4 / 8
LPWSTR                  4 / 8
LRESULT                 4 / 8
PBOOL                   4 / 8
PBOOLEAN                4 / 8
PBYTE                   4 / 8
PCHAR                   4 / 8
PCSTR                   4 / 8
PCTSTR                  4 / 8
PCWSTR                  4 / 8
PDWORD                  4 / 8
PDWORD32                4 / 8
PDWORD64                4 / 8
PDWORDLONG              4 / 8
PDWORD_PTR              4 / 8
PFLOAT                  4 / 8
PHALF_PTR               4 / 8
PHANDLE                 4 / 8
PHKEY                   4 / 8
PINT                    4 / 8
PINT16                  4 / 8
PINT32                  4 / 8
PINT64                  4 / 8
PINT8                   4 / 8
PINT_PTR                4 / 8
PLCID                   4 / 8
PLONG                   4 / 8
PLONG32                 4 / 8
PLONG64                 4 / 8
PLONGLONG               4 / 8
PLONG_PTR               4 / 8
POINTER_32                      ; won't compile
POINTER_64                      ; won't compile
POINTER_SIGNED                  ; won't compile
POINTER_UNSIGNED                ; won't compile
PSHORT                  4 / 8
PSIZE_T                 4 / 8
PSSIZE_T                4 / 8
PSTR                    4 / 8
PTBYTE                  4 / 8
PTCHAR                  4 / 8
PTSTR                   4 / 8
PUCHAR                  4 / 8
PUHALF_PTR              4 / 8
PUINT                   4 / 8
PUINT16                 4 / 8
PUINT32                 4 / 8
PUINT64                 4 / 8
PUINT8                  4 / 8
PUINT_PTR               4 / 8
PULONG                  4 / 8
PULONG32                4 / 8
PULONG64                4 / 8
PULONGLONG              4 / 8
PULONG_PTR              4 / 8
PUSHORT                 4 / 8
PVOID                   4 / 8
PWCHAR                  4 / 8
PWORD                   4 / 8
PWSTR                   4 / 8
QWORD                           ; won't compile
SC_HANDLE               4 / 8
SC_LOCK                 4 / 8
SERVICE_STATUS_HANDLE   4 / 8
SHORT                   2 / 2
SIZE_T                  4 / 8
SSIZE_T                 4 / 8
TBYTE                   1 / 1
TCHAR                   1 / 1
UCHAR                   1 / 1
UHALF_PTR               2 / 4
UINT                    4 / 4
UINT16                  2 / 2
UINT32                  4 / 4
UINT64                  8 / 8
UINT8                   1 / 1
UINT_PTR                4 / 8
ULONG                   4 / 4
ULONG32                 4 / 4
ULONG64                 8 / 8
ULONGLONG               8 / 8
ULONG_PTR               4 / 8
UNICODE_STRING                  ; won't compile
USHORT                  2 / 2
USN                     8 / 8
VOID                            ; won't compile
WCHAR                   2 / 2
WINAPI                          ; won't compile
WORD                    2 / 2
WPARAM                  4 / 8
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
https://raw.githubusercontent.com/HotKeyIt/_Struct/master/_Struct.ahk
