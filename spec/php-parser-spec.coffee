PhpParser = require '../lib/php-parser'

describe "PHP parser", ->
  it "parses variables and functions", ->
    contents = '''class Job extends AbstractEntity
    {
        /**
         * my description
         * @protected
         * @ORM\Column( type="integer")
         * @ORM\Id
         * @ORM\GeneratedValue(strategy="AUTO")
         */
        private $id;

        public function foo();
        '''
    parser = new PhpParser()
    parser.setContent(contents)

    expectedResult = [ { name : 'id', type : 'mixed', description : 'my description', scopeSetter : 'protected', scopeGetter : 'protected' } ]

    expect(parser.getVariables()).toEqual(expectedResult)
    expect(parser.getFunctions()).toEqual(['foo'])
