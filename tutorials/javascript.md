
# Debug global errors

<script>
  (function() {
  ['Error', 'TypeError', 'SyntaxError', 'ReferenceError', 'URIError', 'EvalError', 'InternalError', 'RangeError'].forEach((errName) => {
    var err = window[errName];

    window[errName] = function (message) {
      this.constructor.prototype.__proto__ = err.prototype
      //err.captureStackTrace(this, this.constructor)
      this.name = 'x-' + errName;
      this.message = message

      console.error(this);
    }
  })
}());
</script>
