{View} = require 'atom'

module.exports =
class UIView extends View

  @content: (params)->
    @div class: 'php-getters-setters overlay from-top', =>
        @h1 "Getters and Setters"
        @p "select a variable"
        @ul class: 'var-list', =>
          for variable in params.variables
              @li =>
                  @label =>
                      @input type: "checkbox", value: variable.name
                      @text(variable.name)

        @p "what to generate ?"
        @select class: "action", =>
            @option value: 'all', "Getters and Setters"
            @option value: 'getters', "Getters"
            @option value: 'setters', "Setters"

        @footer =>
            @button class:"primary", click: 'generate', "go!"
            @button class:"secondary", click: 'destroy', "close"

  initialize: (params) ->
    @variables = params.variables
    @caller = params.caller

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()


  generate: ->



      checked = @find('.var-list input:checked')
      vars = []
      for i in checked
          for variable in @variables
              if i.value == variable.name
                  vars.push variable

      action = @find('select.action').val()

      console.log action

      if "all" == action
          @caller.allGettersSetter(vars)

      if "getters" == action
          @caller.allGetters(vars)

      if "setters" == action
          @caller.allSetters(vars)



      @destroy()
