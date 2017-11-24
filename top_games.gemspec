lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'top_games/version'

Gem::Specification.new do |spec|
  spec.name          = 'top_games'
  spec.version       = TopGames::VERSION
  spec.authors       = ['Morgan Fudge']
  spec.email         = ['mfudge92@gmail.com']

  spec.summary       = 'Pulls the top selling games from steam'
  spec.homepage      = 'https://github.com/TestUser1234561/top-games-cli-app'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'nokogiri'
  spec.add_development_dependency 'rake', '~> 10.5.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end