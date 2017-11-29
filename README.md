# TopGames

A Ruby Gem that pulls the current top selling games from steam.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'top_games'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install top_games

## Usage
##### CLI
* Execute `top-games` in the bin directory to initiate a simple command line interface.
##### Code
* Include `top_games.rb` into your project and use `TopGames::Scraper` to return an array of steam games.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/TestUser1234561/top-games-cli-app).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
