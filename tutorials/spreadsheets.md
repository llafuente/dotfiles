# map values

    VLOOKUP(<CELL>;<RANGE_START>:<RANGE_END>;2;FALSE)

inside `ArrayFormula`:

    VLOOKUP(RAW!J:J;MASTERDATA!$A$2:MASTERDATA!$B$200;2;FALSE)

# about: empty rows

When using: `ArrayFormula` or any other way of copy cells you should know that

* `IFERROR(1/0)` means empty
* "" means empty string

Both are true against `ISBLANK` but empty string creates the row.


# Dynamic ranges

## cell ranges

    A1 = "A2:A15"

    INDIRECT(A1)

## names ranges

Data > Named ranges > Add a range



# Formulas

```
=ArrayFormula(
  IF(
    ROW(RAW!M:M)=1;
    RAW!N1;
    IF(
      ISBLANK(RAW!G:G);
      IFERROR(1/0);
      RAW!N:N
    )
  )
)
```
