
module.exports =
class variable

    constructor: (name, type, description, visibility, getterScope, setterScope) ->
        @name        = name
        @type        = type || "unknown"
        @description = description || @getHumanReadableVariableName(name)
        @visibility  = visibility || "private"
        @getterScope = getterScope || "public"
        @setterScope = setterScope || "public"

    getName: ->
        return @name

    setName: (value) ->
        @name = value

    getType: ->
        return @type

    setType: (value) ->
        @type = value || "unknown"

    getDescription: ->
        return @description

    getVisibility: ->
        return @visibility

    getGetterScope: ->
        return @getterScope

    getSetterScope: ->
        return @setterScope

    getHumanReadableVariableName: (variableName) ->
        parts = variableName.split('_')
        if null == parts
            parts = [variable]

        name = ''
        for part in parts
            subParts = (part.charAt(0).toUpperCase() + part.slice 1 ).match(/_(.*)|([A-Z][a-z]+)/g)
            if subParts
                for part in subParts
                    name +=  part + ' '
            else
                name += part + ' '

        return name.trim()
