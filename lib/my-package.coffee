MyPackageView = require './my-package-view'
BaseCommand = require './base-command'
PhpParser = require './php-parser'
ClassWritter = require './class-writter'

module.exports =
    myPackageView: null

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
        @bc = new BaseCommand()
        @parser = new PhpParser()
        x = @bc.getEditorContents()
        @parser.setContent(x)
        return {
            variables: @parser.getVariables(),
            functions: @parser.getFunctions()
        }

    allGettersSetter: ->
        data = @parse()
        # console.log(data)
        variables = data.variables
        functions = data.functions

        cw = new ClassWritter(functions)

        editor = atom.workspace.getActiveEditor()

        code = ''
        for variable in variables
            code += cw.writeGetter(variable.name, variable.type, variable.description)
            code += cw.writeSetter(variable.name, variable.type, variable.description)

        @bc.writeAtEnd(code)

    allGetters: ->
        data = @parse()
        # console.log(data)
        variables = data.variables
        functions = data.functions

        cw = new ClassWritter(functions)

        editor = atom.workspace.getActiveEditor()

        code = ''
        for variable in variables
            code += cw.writeGetter(variable.name, variable.type, variable.description)

        @bc.writeAtEnd(code)

    allSetters: ->
        data = @parse()
        # console.log(data)
        variables = data.variables
        functions = data.functions

        cw = new ClassWritter(functions)

        editor = atom.workspace.getActiveEditor()

        code = ''
        for variable in variables
            code += cw.writeSetter(variable.name, variable.type, variable.description)

        @bc.writeAtEnd(code)
