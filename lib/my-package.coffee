MyPackageView = require './my-package-view'
BaseCommand = require './base-command'
PhpParser = require './php-parser'
TemplateManager = require './template-manager'
UIView = require './ui.view'

module.exports =
    myPackageView: null

    configDefaults:
        doNotTypeHint: ["mixed", "int","integer", "double", "float", "number", "string", "boolean", "bool", "numeric", "unknown"]
        camelCasedMethodNames: true
        generateSettersFirst: false
        getterTemplate: "
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
        setterTemplate: "
\ \ \ \ /** \n
\ \ \ \ * Set the value of %description% \n
\ \ \ \ * \n
\ \ \ \ * @param %type% %variable%\n
\ \ \ \ * \n
\ \ \ \ * @return self\n
\ \ \ \ */\n
\ \ \ %scope% function %methodName%(%typeHint%$value)\n
\ \ \ {\n
\ \ \ \ \ \ \ $this->%variable% = $value;\n
\n
\ \ \ \ \ \ \ return $this;\n
\ \ \ }\n
\n"


    activate: (state) ->
        # @myPackageView = new MyPackageView(state.myPackageViewState)
        #atom.workspaceView.command "my-package:parse", => @parse()
        atom.workspaceView.command "php-getters-setters:allGettersSetter", => @allGettersSetter()
        atom.workspaceView.command "php-getters-setters:allGetters", => @allGetters()
        atom.workspaceView.command "php-getters-setters:allSetters", => @allSetters()
        atom.workspaceView.command "php-getters-setters:showUI", => @showUI()

    deactivate: ->
        @myPackageView.destroy()

    serialize: ->
        myPackageViewState: @myPackageView.serialize()

    parse: ->
        ignoredTypeHints = atom.config.get 'php-getters-setters.doNotTypeHint'
        @bc = new BaseCommand()
        @parser = new PhpParser(ignoredTypeHints)
        x = @bc.getEditorContents()
        @parser.setContent(x)
        return {
            variables: @parser.getVariables(ignoredTypeHints),
            functions: @parser.getFunctions()
        }

    showUI: ->
        editor = atom.workspace.getActiveEditor()
        unless editor.getGrammar().scopeName is 'text.html.php' or editor.getGrammar().scopeName is 'source.php'
            alert ('this is not a PHP file')
            return

        data = @parse()
        # console.log(data)
        variables = data.variables
        functions = data.functions

        ui = new UIView(variables: variables, caller: @)

        atom.workspaceView.append(ui)


    allGettersSetter: (variables) ->
        editor = atom.workspace.getActiveEditor()
        unless editor.getGrammar().scopeName is 'text.html.php' or editor.getGrammar().scopeName is 'source.php'
            alert ('this is not a PHP file')
            return

        data = @parse()
        variables = variables || data.variables
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

        @bc.writeAtEnd(code)

    allGetters: (variables) ->
        editor = atom.workspace.getActiveEditor()
        unless editor.getGrammar().scopeName is 'text.html.php' or editor.getGrammar().scopeName is 'source.php'
            alert ('this is not a PHP file')
            return

        data = @parse()
        variables = variables || data.variables
        functions = data.functions

        cw = new TemplateManager(functions)

        code = ''
        for variable in variables
            code += cw.writeGetter(variable)

        @bc.writeAtEnd(code)

    allSetters: (variables) ->
        editor = atom.workspace.getActiveEditor()
        unless editor.getGrammar().scopeName is 'text.html.php' or editor.getGrammar().scopeName is 'source.php'
            alert ('this is not a PHP file')
            return

        data = @parse()
        variables = variables || data.variables
        functions = data.functions

        cw = new TemplateManager(functions)

        code = ''
        for variable in variables
            code += cw.writeSetter(variable)

        @bc.writeAtEnd(code)
