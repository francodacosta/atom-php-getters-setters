MyPackageView = require './my-package-view'
BaseCommand = require './base-command'
PhpParser = require './php-parser'
ClassWritter = require './class-writter'

module.exports =
    myPackageView: null

    configDefaults:
        doNotTypeHint: ["mixed", "int","integer", "double", "float", "number", "string", "boolean", "bool", "numeric", "unknown"]
        # doNotTypeHint: "mixed,int,integer,double,float,number,string,boolean,bool,numeric,unknown"


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

        cw = new ClassWritter(functions)

        editor = atom.workspace.getActiveEditor()

        code = ''
        for variable in variables
            code += cw.writeGetter(variable.name, variable.type, variable.typeHint, variable.description)
            code += cw.writeSetter(variable.name, variable.type, variable.typeHint, variable.description)

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
