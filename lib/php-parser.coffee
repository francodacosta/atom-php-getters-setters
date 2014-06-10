Variable = require './variable'


module.exports =
class PhpParser
    variableRegExp : /((?:private|public|protected)[ ]{0,}(?:final|static)?[ ]{0,}(?:\$.*?)[ |=|;].*)/g
    functionRegExp : /function[ ]{0,}(.*)[ ]{0,}\(/g
    content        : ''

    setContent: (@content) ->

    getContent: ->
        return @content

    processLine: (line) ->
        content  = @getContent()
        position = content.indexOf(line)
        content  = content.substring(0, position)
        lines    = content.split("\n").reverse()

        cursor =  0
        start  = -1
        end    = -1

        for x in lines
            x = x.trim()

            if x.search(@variableRegExp)>-1
                start = 0
                end = 0
                break

            if "/**" == x
                start = cursor

            if "*/" == x
                end = cursor

            if start > -1 and end > -1
                break

            cursor++

        docblock = @processDocBlock(lines.slice(end, start).reverse().join('\n'))

        name        = line.match(/\$(\w*)/)[1]
        type        = docblock.type || 'mixed'
        visibility  = line.match(/private|public|protected/)[1] || 'public'
        description = docblock.description
        getterScope = docblock.scopeGetter
        setterScope = docblock.scopeSetter

        # # console.log(name, type, description, visibility, getterScope, setterScope)
        return new Variable(name, type, description, visibility, getterScope, setterScope)

    processDocBlock: (content) ->
        lines = content.split("\n")

        inDescription = true
        description   = ''

        for x in lines
            x = x.trim()
            x = x.replace(/\*\//,'') # remove */
            x = x.replace(/\*/,'') # remove all *
            x = x.trim()

            if x.search(/^@/) > -1
                inDescription = false

            if x.search(/^@var/) > -1
                type = x.replace(/@var/,'').trim()

            if x.search(/^@type/) > -1
                type = x.replace(/@type/,'').trim()

            if x.search(/^@internal/) > -1 || x.search(/^@private/) > -1
                # # console.log('@internal')
                scopeSetter = 'private'
                scopeGetter = 'private'

            if x.search(/^@protected/) > -1
                # # console.log('@protected')
                scopeSetter = 'protected'
                scopeGetter = 'protected'

            if x.search(/^@read-only/) > -1
                # # console.log('@read-only')
                scope = x.replace(/@read-only/,'').trim()
                if 'protected' == scope
                    scope = 'protected'
                else
                    scope = 'private'

                scopeSetter = scope
                scopeGetter = 'public'

                # # console.log('setter', scopeSetter, 'getter', scopeGetter)


            if '' == x
                inDescription = false

            if inDescription && description.length == 0
                description += x

        return {
            type: type,
            description: description,
            scopeSetter: scopeSetter || 'public',
            scopeGetter: scopeGetter || 'public'
        }

    getFunctions: ->
        ret = []

        while data = @functionRegExp.exec @getContent()
            ret.push data[1]

        return ret

    getVariables: ->
        variableLines = @getContent().match(@variableRegExp)

        if ! variableLines
            alert ('No properties found in class')
            return {}

        variables = []
        for line in variableLines
            variables.push (@processLine(line))

        return variables
