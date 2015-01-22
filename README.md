PHP Getters and Setters
=======================

With PHP Getters and Setters you can automatically generate _Getters_ and _Setters_ for your php classes.

The code produced is PSR compatible

Features:
---------

* Generate Getters, Setters or Both
* Select all variables or just some via UI
* Control method scope via a DocBlock tag
* intelligent guessing of variable names, if you use descriptive variable names you do not need to provide a description, the method comment will set accordingly
* supports _ in property names



**Example PHP Code**


```php
class test
{
    /**
     * foo container
     *
     * @var AbcClass
     */
    private $foo;
}
```

**Example class after generating Getters and Setters**

```php
class test
{
    /**
     * foo container
     *
     * @var AbcClass
     */
    private $foo;

    /**
     * Gets the foo container.
     *
     * @return AbcClass
     */
    public function getFoo()
    {
        return $this->foo;
    }

    /**
     * Sets the foo container.
     *
     * @param AbcClass $foo the foo
     *
     * @return self
     */
    public function setFoo(AbcClass $foo)
    {
        $this->foo = $foo;

        return $this;
    }
}
```

As you can see if get to trouble of commenting your variables, the generated functions can be used without modification.

This is an huge time saver!

Special DocBlock tags
---------------------
__@internal__: getter and setter will be private

__@private__: getter and setter will be private

__@protected__: getter and setter will be protected

__@read-only private|protected__: getter will be public, setter will be private or protected (defaults to private)

Settings:
-----------
__doNotTypeHint__: an array of items that when present in *@type* or *@var* declarations are ignored and not used as type hint

__camelCasedMethodNames__: method names will follow PSR rules
PSR states that all method names must be camel cased, if set to false method names won't be Camel Cased

__getterTemplate__: the template for the getter

__setterTemplate__: the template for the setter

## Default templates

### Getter
```php
\ \ \ \ /**\n
\ \ \ \ * Get the value of %description% \n
\ \ \ \ * \n
\ \ \ \ * @return %type%\n
\ \ \ \ */\n
\ \ \ %scope% function %methodName%()\n
\ \ \ {\n
\ \ \ \ \ \ \ return $this->%variable%;\n
\ \ \ }\n
\n
```

### Setter
```php
\ \ \ \ /** \n
\ \ \ \ * Set the value of %description% \n
\ \ \ \ * \n
\ \ \ \ * @param %type% %variable%\n
\ \ \ \ * \n
\ \ \ \ * @return self\n
\ \ \ \ */\n
\ \ \ %scope% function %methodName%(%typeHint%$%variable%)\n
\ \ \ {\n
\ \ \ \ \ \ \ $this->%variable% = $%variable%;\n
\n
\ \ \ \ \ \ \ return $this;\n
\ \ \ }\n
\n
```
