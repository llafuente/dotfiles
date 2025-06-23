# Developer toolbar

* File
* Options
* Customize Ribbon
* Customize the Ribbon (right side)
* Main tabs -> Check: Developer


# List oleObjects

```vba
Sub xxx()
    Dim ws As Worksheet
    Dim obj As OLEObject
    Dim newSheet As Worksheet
    Dim i As Integer

    ' Set the worksheet you want to check
    Set ws = ThisWorkbook.Sheets("Sheet1") ' Change "Sheet1" to your worksheet name

    ' Create a new worksheet to store the list
    Set newSheet = Worksheets.Add
    i = 2

    ' Add headers to the new worksheet
    newSheet.Range("A1").Value = "Name"
    newSheet.Range("B1").Value = "Link Type"

    ' Loop through each OLE object in the worksheet
    For Each obj In ws.OLEObjects
        ' Write the name of the OLE object to the new worksheet
        newSheet.Cells(i, 1).Value = obj.Name

        ' Determine if the object is linked or embedded
        If obj.OLEType = xlOLELink Then
            newSheet.Cells(i, 2).Value = "Linked"
        Else
            newSheet.Cells(i, 2).Value = "Embedded"
        End If

        i = i + 1
    Next obj

End Sub
```

# Get checkbox value

ActiveX checkbox control
```vba
ActiveSheet.OLEObjects("CheckBox1").Object.Value = True
```

Form checkbox control
```vba
ActiveSheet.Shapes("CheckBox1").OLEFormat.Object.Value = xlOn
```
