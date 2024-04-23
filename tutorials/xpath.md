# xpath


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

## select by tagName

    //input
    //a
    //div

## select by class

full match

    //*[@class = 'cls')]"

partial match

    //*[contains(concat(' ', normalize-space(@class), ' '), ' cls ')]"

## select by text

full match

    //*[normalize-space()='text']

left match

    //*[starts-with(normalize-space(), 'text')]

partial match

    //*[contains(normalize-space(), 'text')]"

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

# Examples

Return a div that contains a div with name

    //div[input/@name='username']
    //div/input[@name='username']/..

First element with text

    (//*[normalize-space()='text'])[0]

# Docs

* [XPath/Functions](https://developer.mozilla.org/en-US/docs/Web/XPath/Functions)