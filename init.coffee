# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"
atom.packages.onDidActivatePackage (pack) ->
  if pack.name == 'ex-mode'
    Ex = pack.mainModule.provideEx()
    Ex.registerAlias 'WQ', 'wq'
    Ex.registerAlias 'Wq', 'wq'
    Ex.registerAlias 'W', 'w'
    Ex.registerAlias 'Q', 'q'

atom.commands.dispatch(atom.views.getView(atom.workspace), 'atom-hide-tabs:toggle');
