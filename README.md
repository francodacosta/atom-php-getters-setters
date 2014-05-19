PHP Getters and Setters
=======================

With PHP Getters and Setters you can automatically generate _Getters_ and _Setters_ for your php classes.

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
