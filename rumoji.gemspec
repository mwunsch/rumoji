# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rumoji/version'

Gem::Specification.new do |gem|
  gem.name          = "rumoji"
  gem.version       = Rumoji::VERSION
  gem.authors       = ["Mark Wunsch"]
  gem.email         = ["mark@markwunsch.com"]
  gem.description   = %q{Transcode emoji utf-8 characters into emoji-cheat-sheet form}
  gem.summary       = %q{Transcode emoji utf-8 characters into emoji-cheat-sheet form}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
