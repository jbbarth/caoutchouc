Caoutchouc: a shell for managing Elasticsearch
==============================================

`caoutchouc` is an interactive shell specifically targeted at managing Elasticsearch.

## Installation

There will soon be binary packages, but for now you have to compile the project
yourself:
1. [install crystal](http://crystal-lang.org/docs/installation/index.html)
2. clone this repository and go into the resulting directory
3. compile a binary:
```
mkdir -p ~/bin
crystal build src/caoutchouc.cr -o ~/bin/caoutchouc
```

**WARNING FOR OSX USERS**

On OSX the `readline` version that comes with OSX/Xcode is basically fucked.
For instance it doesn't contain any mean to manipulate the current line buffer,
say, when a Ctrl+C (SIGINT) occurs. Hence this software *won't compile* with
those readline versions, and you're encouraged to install a proper readline,
for instance via Homebrew (`brew install readline`). After that, add your
readline path to the `LIBRARY_PATH` environment variable so it takes precedence
over Xcode's one:
```
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/Cellar/readline/6.3.8/lib/
#then: crystal run / crystal build
```

## Usage

```
caoutchouc <address>
```

Then `help` for commands.

## Development

When developing, it can be useful to rerun specs as soon as some ".cr" file
changes. Everybody has her own thing to do that, but I find that the "rerun"
ruby gem is really flexible and simple.

To install it:
```
gem install rerun
```

To use it in the context of this project (or any Crystal project really):
```
rerun --clear --exit --pattern "**/*.cr" crystal spec
```

## Contributing

1. Fork it ( https://github.com/[your-github-name]/caoutchouc/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [jbbarth](https://github.com/jbbarth) Jean-Baptiste Barth - creator, maintainer
