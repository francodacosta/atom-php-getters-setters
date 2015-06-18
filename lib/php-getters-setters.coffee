BaseCommand        = require './base-command'
PhpParser          = require './php-parser'
TemplateManager    = require './template-manager'
UIView             = require './ui.view'
NewPropertyView    = require './new-property.view'
TemplateEditorView = require './template-editor.view'

module.exports =
    config:
        doNotTypeHint:
            type: 'array'
            default: ["mixed", "int", "integer", "double", "float", "number", "string", "boolean", "bool", "numeric", "unknown"]
            items:
                type: 'string'
        camelCasedMethodNames:
            type: 'boolean'
            title: 'Use CamelCased method names '
            default: true
        generateSettersFirst:
            type: 'boolean'
            title: 'Generate Setters first '
            default: false
        getterTemplate:
            type: 'string'
            description: "You might want to use the template editor ..."
            default: "
\ \ \ \ /**\n
\ \ \ \ * Get the value of %description% \n
\ \ \ \ * \n
\ \ \ \ * @return %type%\n
\ \ \ \ */\n
\ \ \ %scope% function %methodName%()\n
\ \ \ {\n
\ \ \ \ \ \ \ return $this->%variable%;\n
\ \ \ }\n
\n"
        setterTemplate:
            type: 'string'
            description: "You might want to use the template editor ..."
            default: "
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
\n"

    activate: (state) ->
        atom.commands.add 'atom-workspace',
        "php-getters-setters:allGettersSetter": => @allGettersSetter()
        "php-getters-setters:allGetters":       => @allGetters()
        "php-getters-setters:allSetters":       => @allSetters()
        "php-getters-setters:showUI":           => @showUI()
        "php-getters-setters:newPropery":       => @showAddProperty()
        "php-getters-setters:templateEditor":   => @showTemplateEditor()


    parse: ->
        ignoredTypeHints = atom.config.get 'php-getters-setters.doNotTypeHint'
        bc     = new BaseCommand()
        parser = new PhpParser(ignoredTypeHints)

        parser.setContent(bc.getEditorContents())

        return {
            variables: parser.getVariables(ignoredTypeHints),
            functions: parser.getFunctions()
        }

    showAddProperty: ->
        editor = atom.workspace.getActiveTextEditor()

        unless editor.getGrammar().scopeName is 'text.html.php' or editor.getGrammar().scopeName is 'source.php'
            alert ('this is not a PHP file')
            return


        ui = new NewPropertyView(caller: @)

        atom.workspaceView.append(ui)

    showTemplateEditor: ->
        editor = atom.workspace.getActiveTextEditor()

        getter = atom.config.get 'php-getters-setters.getterTemplate'
        setter = atom.config.get 'php-getters-setters.setterTemplate'

        ui = new TemplateEditorView(setter: setter, getter:getter, caller: @)

        ui.show()

    showUI: ->
        editor = atom.workspace.getActiveTextEditor()

        unless editor.getGrammar().scopeName is 'text.html.php' or editor.getGrammar().scopeName is 'source.php'
            alert ('this is not a PHP file')
            return

        data = @parse()
        variables = data.variables
        functions = data.functions

        ui = new UIView(variables: variables, caller: @)

        ui.show()

        # atom.views.getView(atom.workspace).append(ui)
    getVarsToProcess: (selectedVars, varsInClass) ->
        varsToProcess = []
        if selectedVars.length > 0
            for selectedVariable in selectedVars
                for tmpVar in varsInClass
                    if tmpVar.name == selectedVariable.name
                        varsToProcess.push tmpVar
        else
            varsToProcess = varsInClass

        console.log(varsToProcess)
        return varsToProcess

    allGettersSetter: (variables) ->
        editor = atom.workspace.getActiveTextEditor()
        unless editor.getGrammar().scopeName is 'text.html.php' or editor.getGrammar().scopeName is 'source.php'
            alert ('this is not a PHP file')
            return

        data = @parse()
        variables = @getVarsToProcess(variables || [], data.variables)
        functions = data.functions

        cw = new TemplateManager(functions)

        generateSettersFirst = atom.config.get 'php-getters-setters.generateSettersFirst'

        code = ''
        for variable in variables

            if generateSettersFirst
                code += cw.writeSetter(variable)
                code += cw.writeGetter(variable)
            else
                code += cw.writeGetter(variable)
                code += cw.writeSetter(variable)

        bc = new BaseCommand()
        bc.writeAtEnd(code)

    allGetters: (variables) ->
        editor = atom.workspace.getActiveTextEditor()
        unless editor.getGrammar().scopeName is 'text.html.php' or editor.getGrammar().scopeName is 'source.php'
            alert ('this is not a PHP file')
            return

        data = @parse()

        variables = @getVarsToProcess(variables || [], data.variables)
        functions = data.functions

        cw = new TemplateManager(functions)

        code = ''
        for variable in variables
            code += cw.writeGetter(variable)

        bc = new BaseCommand()
        bc.writeAtEnd(code)

    allSetters: (variables) ->
        editor = atom.workspace.getActiveTextEditor()
        unless editor.getGrammar().scopeName is 'text.html.php' or editor.getGrammar().scopeName is 'source.php'
            alert ('this is not a PHP file')
            return

        data = @parse()
        variables = @getVarsToProcess(variables || [], data.variables)
        functions = data.functions

        cw = new TemplateManager(functions)

        code = ''
        for variable in variables
            code += cw.writeSetter(variable)

        bc = new BaseCommand()
        bc.writeAtEnd(code)
