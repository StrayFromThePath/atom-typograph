{CompositeDisposable} = require 'atom'

class Typograph
  constructor: (@config) ->

  convert: (lang, tags) ->
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getSelectedText()
      Typograf = require 'typograf'
      tp = new Typograf(lang: lang, mode: 'name')
      if tags
        tp.enable('common/html/pbr');
      editor.insertText(tp.execute(selection))

module.exports =
  subscriptions: null

  activate: ->

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'typograph:convertEn': => @convertEn()
    @subscriptions.add atom.commands.add 'atom-workspace', 'typograph:convertRu': => @convertRu()
    @subscriptions.add atom.commands.add 'atom-workspace', 'typograph:convertRuWithTags': => @convertRuWithTags()
    @subscriptions.add atom.commands.add 'atom-workspace', 'typograph:convertEnWithTags': => @convertEnWithTags()

  deactivate: ->
    @subscriptions.dispose()

# Typography for Russian language
  convertRu: ->
    langRu = new Typograph
    langRu.convert('ru')

# Typography for English language
  convertEn: ->
    langEn = new Typograph
    langEn.convert('en')

# Typography for Russian language without html-tags 
  convertRuWithTags: ->
    langRu = new Typograph
    langRu.convert('ru',true)

# Typography for English language without html-tags
  convertEnWithTags: ->
    langEn = new Typograph
    langEn.convert('en',true)
