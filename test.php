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
     * @var integer
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
     * the conversion status (running, aborted, etc)
     * @var string
     *
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $status;

    /**
     * starting time
     *
     * @var \DateTime
     *
     * @ORM\Column(type="datetime", nullable=true)
     */
    private $started;

    /**
     * end time
     *
     * @var \DateTime
     *
     * @ORM\Column(type="datetime", nullable=true)
     */
    private $finished;

    /**
     * was the job successful
     * @var boolean
     *
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $success;

    /**
     * is the conversion part of the job done ?
     * @var boolean
     *
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $conversionDone;


    public function __construct()
    {
        $this->started = new \DateTime;
        $this->conversionDone = false;
    }

}
