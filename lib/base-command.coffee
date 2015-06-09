module.exports =
class BaseCommand

    appliesToCurrentEditor: ->
        editor = Workspace.getActiveEditor()

        unless editor.getGrammar().scopeName is 'text.html.php'
            console.warn "Cannot run for non php files"
            return false

        return true

    writeAtEnd: (text) ->
        content = @getEditorContents()
        last = content.lastIndexOf('}')
        editor = Workspace.getActiveTextEditor()

        editor.setText ([content.slice(0, last), "\n"+text, content.slice(last)].join(''))

    getEditorContents: ->
        editor = Workspace.getActiveTextEditor()

        return editor.getText()
