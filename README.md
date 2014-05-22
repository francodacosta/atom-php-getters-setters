PHP Getters and Setters
=======================

With PHP Getters and Setters you can automatically generate _Getters_ and _Setters_ for your php classes.

The code produced is PSR compatible

This is a port of the sublime text plugin https://github.com/francodacosta/sublime-php-getters-setters/ only with the basic functionality.
In the near future all features will be ported

Features:
---------

* Generate Getters, Setters or Both
* Control method scope via a DocBlock tag
* intelligent DocBlocks, if you use descriptive variable names you do not need to provide a description, the method comment will set acrodingly



**Example PHP Code**


```php
class test
{
    /**
     * @protected
     * @ORM\Column( type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * the job id
     * @read-only
     * @var string
     *
     * @ORM\Column(type="string", length=255)
     */
    private $code;

    /**
     * snake cased var
     *
     * @var string
     */
    private $snaked_case_var;

    /**
     * private underscore variable
     *
     * @var string
     */
    private $_underscored;

    /**
     * @var string
     */
    private $smartVariableName;

    }
}
```

**Example class after generating Getters and Setters**

```php
class test
{
    /**
     * @protected
     * @ORM\Column( type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * the job id
     * @read-only
     * @var string
     *
     * @ORM\Column(type="string", length=255)
     */
    private $code;

    /**
     * snake cased var
     *
     * @var string
     */
    private $snaked_case_var;

    /**
     * private underscore variable
     *
     * @var string
     */
    private $_underscored;

    /**
     * @var string
     */
    private $smartVariableName;


    /**
     * Get the value of Id
     *
     * @return mixed
     */
    protected function getId()
    {
        return $this->id;
    }

    /**
     * Set the value of Id
     *
     * @param mixed id
     *
     * @return self
     */
    protected function setId($value)
    {
        $this->id = $value;

        return $this;
    }

    /**
     * Get the value of the job id
     *
     * @return string
     */
    public function getCode()
    {
        return $this->code;
    }

    /**
     * Set the value of the job id
     *
     * @param string code
     *
     * @return self
     */
    private function setCode($value)
    {
        $this->code = $value;

        return $this;
    }

    /**
     * Get the value of snake cased var
     *
     * @return string
     */
    public function getSnakedCaseVar()
    {
        return $this->snaked_case_var;
    }

    /**
     * Set the value of snake cased var
     *
     * @param string snaked_case_var
     *
     * @return self
     */
    public function setSnakedCaseVar($value)
    {
        $this->snaked_case_var = $value;

        return $this;
    }

    /**
     * Get the value of private underscore variable
     *
     * @return string
     */
    public function getUnderscored()
    {
        return $this->underscored;
    }

    /**
     * Set the value of private underscore variable
     *
     * @param string underscored
     *
     * @return self
     */
    public function setUnderscored($value)
    {
        $this->underscored = $value;

        return $this;
    }

    /**
     * Get the value of Smart Variable Name
     *
     * @return string
     */
    public function getSmartVariableName()
    {
        return $this->smartVariableName;
    }

    /**
     * Set the value of Smart Variable Name
     *
     * @param string smartVariableName
     *
     * @return self
     */
    public function setSmartVariableName($value)
    {
        $this->smartVariableName = $value;

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
__doNotTypeHint__: an array of items that when present in *@var* declaration are ignored and not used as type hint
when using the gui settings this is a comma separated list of terms

__camelCasedMethodNames__: method names will follow PSR rules
PSR states that all method names must be camel cased, if set to false method names won't be Camel Cased

__getterTemplate__: the template for the getter

__setterTemplate__: the template for the setter
