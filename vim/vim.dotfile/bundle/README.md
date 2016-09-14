# Notes

## Plugins

### Elixir

#### Alchemist

Client-Server app for Elixir development. Primarily for Emacs - but a Vim plugin exists. Note that the plugin installs Alchemist as part of the actual plugin - the are no further dependencies.

#### mix.vim

Plugin for using Elixirs build tool ```mix```.

#### vim-elixir

Elixir support for vim, including syntax highlighting, indentation, etc

###  Syntastic

Verified basic setup is working ok by issuing `:Helptags`

List installed checkers for the detected type of the current file via `:SyntasticInfo`

Note that the underlying syntax checkers need to be installed and configured independently. For a list of supported syntax checkers see: Syntax checkers: https://github.com/scrooloose/syntastic/wiki/Syntax-Checkers

###  vim-indent-guides

Ensure that identation is enabled in the .vimrc. See http://vim.wikia.com/wiki/Indenting_source_code 

For example, the following will setup Vim indentation without hard tabs:

set expandtab
set shiftwidth=2
set softtabstop=2

The plugin is toggled using <Leader>ig.

To verify it has loaded correctly verify the following is truthy `:echo g:loaded_indent_guides`.

### Tabularize

E.g. to align on =
```shell
:Tabularize /=
```

Certain frequently used variants have been mapped to <leader> key combinations using the ```after/plugin/tabularize.vim``` vim script. 
Note this relies on the Tabularize plugin have been loaded - hence why it needs to be performed after all plugins have been loaded.

It is also wired up to auto-align cucumber tables on the <pipe> character. This is done in the ```after/plugin/cucumbertables.vim``` script that is taken from [this Tim Pope scgist](https://gist.github.com/tpope/287147)

Example cucumber table for reference:
```gherkin
Scenario Outline: something
	Given there are <start> things
	When I remove <removed> things
	Then I should have <remaining> things

	Examples:
	| start | removed | remaining |
	| 10    | 2       | 8         |
```

## Linters

### JSCS

Configuration of JSCS is via presets ( see http://jscs.info/overview#preset ), e.g. based off Google JavaScript style guides. 
This buik of the JSCS configuration file is then just selecting the desired preset and providing any overrides as necessary - i.e. it wont have much in it.
Note - as the presents are baked into JSCS, simply updating JSCS updates the presets and the associated linter rules. I.e there is no need to manually reconcile linter rules against the reference set.
