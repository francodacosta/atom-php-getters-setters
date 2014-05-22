PHP Getters and Setters
=======================

With PHP Getters and Setters you can automatically generate _Getters_ and _Setters_ for your php classes.

The code produced is PSR compatible

This is a port of the sublime text plugin https://github.com/francodacosta/sublime-php-getters-setters/ only with the basic functionality.
In the near future all features will be ported

Features:
---------

* Generate Getters, Setters or Both



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
     */
    public function setFoo(AbcClass $foo)
    {
        $this->foo = $foo;
    }
}
```

As you can see if get to trouble of commenting your variables, the generated functions can be used without modification.

This is an huge time saver!

Special DocBlock tags
---------------------
_@internal_: getter and setter will be private

_@private_: getter and setter will be private

_@protected_: getter and setter will be protected

_@read-only private|protected_: getter will be public, setter will be private or protected (defaults to private)

Settings:
-----------
_doNotTypeHint_: an array of items that when present in *@var* declaration are ignored and not used as type hint
when using the gui settings this is a comma separated list of terms

_camelCasedMethodNames_: method names will follow PSR rules
PSR states that all method names must be camel cased, if set to false method names won't be Camel Cased

_getterTemplate_: the template for the getter

_setterTemplate_: the template for the setter
