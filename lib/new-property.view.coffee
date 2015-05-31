{View} = require 'atom-space-pen-views'

module.exports =
class NewPropertView extends View

    @content: (params)->
        @div class: 'php-getters-setters overlay from-top', =>
            @h1 "Add new Property"
            @form role: "form", =>

                @div class: 'col-md-4', =>

                    # @div class: "form-group", =>
                        @h3 "Visibility"
                        @select class: "form-control", name: "selGetter", =>
                            @option value: "public",    selected: true,  "public"
                            @option value: "private" , "private"
                            @option value: "protected", "protected"

                @div class: 'col-md-4', =>

                # @div class: "form-group", =>
                    @h3 for: "txtName", "Name"
                    # i'm not sure why but some other handler is catching the keys for the inputs
                    @input class: 'form-control', keydown: 'keyDown', name: "txtName"

                @div class: 'col-md-4', =>
                # @div class: "form-group", =>
                    @h3 for: "txtType", "Type"
                    # i'm not sure why but some other handler is catching the keys for the inputs
                    @input class: 'form-control', name: "txtType"


                @div class: 'col-md-12', =>
                    @div class: "form-group", =>
                        @h3 for: "txtDesc", "Description"
                        # i'm not sure why but some other handler is catching the keys for the inputs
                        @input class: 'form-control', name: "txtDesc"

                    @div class: "form-group", =>
                        @h3 "Getter"
                        @select class: "form-control", name: "selGetter", =>
                            @option value: "public",    selected: true,  "public"
                            @option value: "private" , "private"
                            @option value: "protected", "protected"
                            @option value: "off"     , "do not generate"

                    @div class: "form-group", =>
                        @h3 "Setter"
                        @select class: "form-control", name: "selSetter", =>
                            @option value: "public",    selected: true,  "public"
                            @option value: "private" , "private"
                            @option value: "protected", "protected"
                            @option value: "off"     , "do not generate"



            @footer =>
                @button class:"primary", click: 'generate', "go!"
                @button class:"secondary", click: 'destroy', "close"

    initialize: (params) ->
        @caller = params.caller

    # Tear down any state and detach
    destroy: ->
        @detach()

    keyDown: (evt) ->
        # we need this otherwise the input elements do not process arrow keys or the backspace
        # i'm nto sure why but i think some other code (in other package) is preventint this
        evt.stopPropagation()


    generate: ->


        @destroy()
