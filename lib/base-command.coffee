module.exports =
class BaseCommand

    appliesToCurrentEditor: ->
        editor = atom.workspace.getActiveEditor()

        unless editor.getGrammar().scopeName is 'text.html.php'
            console.warn "Cannot run for non php files"
            return false

        return true

    writeAtEnd: (text) ->
        content = @getEditorContents()
        last = content.lastIndexOf('}')
        editor = atom.workspace.getActiveEditor()

        editor.setText ([content.slice(0, last), "\n"+text, content.slice(last)].join(''))

    getEditorContents: ->
        editor = atom.workspace.getActiveEditor()

        return editor.getText()
