# debug element position

```js
var rect = { left: 100, top: 100, width:200, height: 20}

var div = document.createElement("div")
document.body.appendChild(div)
div.style.position = "absolute";
div.style.left = rect.left + "px";
div.style.top = rect.top + "px";
div.style.width = rect.width + "px";
div.style.height = rect.height + "px";
div.style.backgroundColor = "rgba(255,0,0,0.25)";
```
