MyPackageView = require './my-package-view'
BaseCommand = require './base-command'
PhpParser = require './php-parser'
ClassWritter = require './class-writter'
TemplateManager = require './template-manager'

module.exports =
    myPackageView: null

    configDefaults:
        doNotTypeHint: ["mixed", "int","integer", "double", "float", "number", "string", "boolean", "bool", "numeric", "unknown"]
        camelCasedMethodNames: true
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

    allGettersSetter: ->

        data = @parse()
        # console.log(data)
        variables = data.variables
        functions = data.functions

        cw = new TemplateManager(functions)

        editor = atom.workspace.getActiveEditor()

        code = ''
        for variable in variables
            code += cw.writeGetter(variable)
            code += cw.writeSetter(variable)

        @bc.writeAtEnd(code)

    allGetters: ->
        data = @parse()
        # console.log(data)
        variables = data.variables
        functions = data.functions

        cw = new TemplateManager(functions)

        code = ''
        for variable in variables
            code += cw.writeGetter(variable)

        @bc.writeAtEnd(code)

    allSetters: ->
        data = @parse()
        variables = data.variables
        functions = data.functions

        cw = new TemplateManager(functions)

        code = ''
        for variable in variables
            code += cw.writeSetter(variable)

        @bc.writeAtEnd(code)
