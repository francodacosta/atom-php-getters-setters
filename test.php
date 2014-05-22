<?php

namespace Flooved\Docs\ApiBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Job
 *
 * @ORM\Table()
 * @ORM\Entity
 */
class Job extends AbstractEntity
{
    /**
     *
     * @ORM\Column( type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * the job id
     *
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


    public function __construct()
    {
        $this->started = new \DateTime;
        $this->conversionDone = false;
    }
}
