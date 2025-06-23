# Logic

> AND(x, y, z)

> OR(x, y, z)

# Change row style (background) based on a column

* Menu: Format -> Conditional Formatting -> Add another rule
* Apply to range: Your range
* Custom formula is

  =$A1="xxx"

* Formatting style: Your format

# Get value for current cell

This is usefull to validate, do not set it as cell formula.

    INDIRECT(ADDRESS(ROW(),COLUMN()))

# Validate cell length

* Data validation
* Add Rule
* Custom Formula

>     =LEN(INDIRECT(ADDRESS(ROW(),COLUMN())))<17

* Check: Reject Input


