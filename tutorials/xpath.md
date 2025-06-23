# xpath


## Operators

| Operator | Explanation                                                   |
| -------- | ------------------------------------------------------------- |
| =        | Equivalent comparison, can be used for numeric or text values |
| !=       | Is not equivalent comparison                                  |
| >, >=    | Greater than, greater than or equal to                        |
| <, <=    | Less than, less than or equal to                              |
| or       | Boolean or                                                    |
| and      | Boolean and                                                   |
| not      | Boolean not                                                   |

## Selection (axes)

### self

	.

### parent

	..

### child

    /

### descendant

    //

### attribute

    @

### siblings to the right

    following-sibling::

### siblings to the left

    preceding‐sibling::

### All following nodes in the document, excluding descendants

    following::

### All preceding nodes in the document, excluding ancestors • attribute ‐‐ the attributes of the context node

    preceding::

## select by tagName

    //input
    //a
    //div

## select by class

full match

    //*[@class = 'cls')]"

normalized partial match

    //*[contains(concat(' ', normalize-space(@class), ' '), ' cls ')]"

## select by text (In-text search)

NOTE: user `.` for current text, `normalize-space()` for current text normalized

full match

    //*[normalize-space()='text']

left match

    //*[starts-with(normalize-space(), 'text')]

right match

    //*[ends-with(normalize-space(), 'text')]

partial match

    //*[contains(normalize-space(), 'text')]"

regular expression match

    //author[matches(.,"Matt.*")]


## select by attribute

by name

    //*[@name='thename']

by id

    //*[@id='theid']

## select last element

    (//*)[last()]

## select first element

    (//*)[0]

## select nth element

    (//*)[n]

## select by position

    (//*)[position() < 3]

## select any attribute with value

    //*[@*="value"]

## select element with no attributes

    //*[count(@*)=0]


## Select Nodes with no attributes OR all empty

    //*[not(@*) or not(string-length(@*))]


## Select deepest node
Note: The node selected won't match the precious selection. It will get the deepest of the precious selection.

    xpath/descendant::*[last()]


# Examples

Return a div that contains a div with name

    //div[input/@name='username']
    //div/input[@name='username']/..

First element with text

    (//*[normalize-space()='text'])[0]

# Docs

* [XPath/Functions](https://developer.mozilla.org/en-US/docs/Web/XPath/Functions)
