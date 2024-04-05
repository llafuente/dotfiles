# Typescript snippets


## declare Object with any key and value

```
{
    [name: string]: any;
}
```

## Function interaface

```ts
interface I {
    (data: string): string;
};
```

## abstract class

```ts
abstract class XXX {
  abstract YYY () : void;
}
```


## getter/setter

```ts
class Person {
    private _age: number;
 
    public get age() {
        return this._age;
    }

    public set age(theAge: number) {
        this._age = theAge;
    }
}
```