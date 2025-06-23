Use seleniumbasic (chrome) from powershell

js


```js
div = document.createElement("div")
document.body.appendChild(div)

document.body.onclick = function () { console.log("click", this); }
document.body.ondblclick = function () { console.log("doubleclick", this); }
```

powershell

```ps1
$obj = New-Object -ComObject Selenium.ChromeDriver
$obj.start()
$obj.open("about:blank")

$bodies = $obj.findElementsByXPath("//body")
$body = $bodies.item(0)
$obj.Actions.Click($body).wait(250).Perform()
$obj.Actions.ClickDouble($body).Perform()



$elements = $obj.findElementsByXPath("//div")
$element = $elements.item(0)
$element.Attribute("style", "background-color: red")
$obj.Actions.Click($element).wait(250).Perform()
$obj.Actions.ClickDouble($element).wait(250).Perform()



$element | Select-Object -Property *

```
