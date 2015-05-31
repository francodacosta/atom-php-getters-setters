{View} = require 'atom-space-pen-views'

module.exports =
class TemplateEditorView extends View

    @content: (params)->
        @div class: 'php-getters-setters overlay from-top', =>
            @h1 "Template Editor"
            @div class: 'col-md-6', =>
                @h2 "Getter"
                @textarea id: "txtGetter" , style: "width: 100%; height: 250px", keydown: 'keyDown'
            @div class: 'col-md-6', =>
                @h2 "Setter"
                @textarea id: "txtSetter", style: "width: 100%; height: 250px", keydown: 'keyDown'

            @footer =>
                @button class:"primary", click: 'save', "Save"
                @button class:"secondary", click: 'destroy', "close"

    initialize: (params) ->
        @params = params
        # @caller = params.caller
        console.log params
        @find('#txtGetter').text(params.getter)
        @find('#txtSetter').text(params.setter)


    # Tear down any state and detach
    destroy: ->
        @modalPanel.destroy()
        @detach()

    show: ->
        @modalPanel = atom.workspace.addModalPanel(item: @, visible: true)

    keyDown: (evt) ->
        # we need this otherwise the input elements do not process arrow keys or the backspace
        # i'm nto sure why but i think some other code (in other package) is preventint this
        evt.stopPropagation()


    sanitizeTemplate: (template) =>
        return template
                    .replace(/[^\S\r\n]+$/gm, '')
                    .replace(/\ /g, "\\ ")
                    # .replace(/\n/g, "\\n")

    save: ->
        getterTemplate = @sanitizeTemplate(@find('#txtGetter').val())
        setterTemplate = @sanitizeTemplate(@find('#txtSetter').val())

        console.log getterTemplate

        atom.config.set 'php-getters-setters.getterTemplate', """#{getterTemplate}"""
        atom.config.set 'php-getters-setters.setterTemplate', """#{setterTemplate}"""

        @destroy()
