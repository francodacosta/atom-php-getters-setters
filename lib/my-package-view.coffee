{View} = require 'atom'

module.exports =
class MyPackageView extends View
  @content: ->
    @div class: 'my-package overlay from-top', =>
      @div "The FOO MyPackage package is Alive! It's ALIVE!", class: "message"

  initialize: (serializeState) ->
    # atom.workspaceView.command "my-package:toggle", => @toggle()
    # atom.workspaceView.allGettersSetter "my-package:allGettersSetter", => @allGettersSetter()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  
  toggle: ->
    console.log "MyPackageView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
