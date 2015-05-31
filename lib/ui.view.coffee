{View} = require 'atom-space-pen-views'

module.exports =
class UIView extends View

    @content: (params)->
        @div class: 'php-getters-setters overlay from-top', =>
            @h1 "Getters and Setters"
            @p "select the properties to generate accessors methods for"
            # @ul class: 'var-list', =>
            #   for variable in params.variables
            #       @li =>
            #           @label =>
            #               @input type: "checkbox", value: variable.name
            #               @text(variable.name)
            @table class: 'var-list', =>
                @tr =>
                    @th ""
                    @th "name"
                    @th "type"
                    @th ""
                for variable in params.variables
                    @tr =>
                        @td =>
                            @input type: "checkbox", value: variable.name, id: 'chk_variable_' + variable.name
                        @td =>
                            @label for: 'chk_variable_' + variable.name, =>
                                @text(variable.name)
                        @td =>
                            @label for: 'chk_variable_' + variable.name, =>
                                @text(variable.type)
                        @td

            @p "what accessors do you want generated ?"
            @label =>
                @input type: "checkbox", value: true, checked: true, id: 'chk_accessor_getter'
                @text("Getters")
            @label =>
                @input type: "checkbox", value: true, checked: true, id: 'chk_accessor_setter'
                @text("Setters")
            # @select class: "action", =>
            #     @option value: 'all', "Getters and Setters"
            #     @option value: 'getters', "Only Getters"
            #     @option value: 'setters', "Only Setters"

            @footer =>
                @button class:"primary", click: 'generate', "go!"
                @button class:"secondary", click: 'destroy', "close"

    initialize: (params) ->
        @variables = params.variables
        @caller = params.caller

    # Tear down any state and detach
    destroy: ->
        @modalPanel.destroy()
        @detach()

    show: ->
        @modalPanel = atom.workspace.addModalPanel(item: @, visible: true)

    getElement: ->
        return @find('.php-getters-setters.overlay')

    generate: ->
        checked = @find('.var-list input:checked')
        vars = []
        for i in checked
          for variable in @variables
              if i.value == variable.name
                  vars.push variable

        doGetter = @find('#chk_accessor_getter').prop('checked');
        doSetter = @find('#chk_accessor_setter').prop('checked');

        if (doGetter && doSetter)
          @caller.allGettersSetter(vars)
        else if (doGetter)
          @caller.allGetters(vars)
        else if (doSetter)
          @caller.allSetters(vars)


        @destroy()
