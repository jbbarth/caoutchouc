Caoutchouc: a shell for Elasticsearch
=====================================

`caoutchouc` is an interactive shell specifically targeted at managing
Elasticsearch. It especially focuses on making cumbersome tasks easier.


## Installation

Go download the correct version of the tool on the [releases page](https://github.com/jbbarth/caoutchouc/releases).

If you better like command-line, here we go:

... for Linux 64bits users:
```
sudo curl -L https://github.com/jbbarth/caoutchouc/download/v0.0.2/caoutchouc_linux-amd64 -o /usr/local/bin/caoutchouc
sudo chmod +x /usr/local/bin/caoutchouc
```

... for Mac OSX users:
```
sudo curl -L https://github.com/jbbarth/caoutchouc/download/v0.0.2/caoutchouc_darwin-amd64 -o /usr/local/bin/caoutchouc
sudo chmod +x /usr/local/bin/caoutchouc
```


## Usage

```
caoutchouc [address]
```

Then `help` for commands.


## Development

If you want to build this project yourself (for development purposes, no need
if you just want to use it!!), you may have to compile the project
yourself:

1. [install crystal](http://crystal-lang.org/docs/installation/index.html)
2. clone this repository and go into the resulting directory
3. compile a binary:

```
mkdir -p ~/bin
crystal build src/caoutchouc.cr -o ~/bin/caoutchouc
```

**Warning for OSX developers**

On OSX the `readline` version that comes with OSX/Xcode is basically fucked.
For instance it doesn't contain any mean to manipulate the current line buffer,
say, when a Ctrl+C (SIGINT) occurs. It also has bugs in the way it handles
the line buffer, which is not updated synchronously, while it should.

Hence this software *won't compile* with those readline versions, and you're
strongly encouraged to install a proper readline, for instance via Homebrew
(`brew install readline`). After that, add your readline path to the
`LIBRARY_PATH` environment variable so it takes precedence over Xcode's one:
```
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/Cellar/readline/6.3.8/lib/
#then: crystal run / crystal build
```

**Running specs**

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

Any contribution, being code, documentation, feedback, or really anything is
welcome. If you're not sure how to do, don't hesitate to file [a new
issue](https://github.com/jbbarth/caoutchouc/issues/new) and we'll get over
that together.

If you want to do code or docs contributions, here's the preferred way:

1. Fork it ( https://github.com/[your-github-name]/caoutchouc/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request


## Contributors

- [jbbarth](https://github.com/jbbarth) Jean-Baptiste Barth - creator, maintainer
