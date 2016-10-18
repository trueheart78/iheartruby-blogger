# I :heart: Ruby [![CircleCI](https://circleci.com/gh/trueheart78/simple-cli-tools.svg?style=shield)](https://circleci.com/gh/trueheart78/simple-cli-tools)

Because I am lazy, but mostly, because I love Ruby.

## Running Tests

```ruby
bundle install
bundle exec rake test
```

## Adding a Binary

```sh
touch bin/awesome_cmd
chmod +x bin/awesome_cmd
```

## Adding to Your Path

Run the init script:

```sh
./script/init
```

And follow the directions:

```
----------------------------------------------------------------------
Add the following to your shell profile of choice:

export PATH="$PATH:/home/josh/Programming/Ruby/iheartruby-blogger/bin"
----------------------------------------------------------------------
```