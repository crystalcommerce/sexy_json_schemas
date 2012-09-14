# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sexy_json_schemas/version'

Gem::Specification.new do |gem|
  gem.name          = "sexy_json_schemas"
  gem.version       = "0.0.1"
  gem.authors       = ["Donald Plummer", "Michael Xavier"]
  gem.email         = ["donald@crystalcommerce.com", "xavier@crystalcommerce.com"]
  gem.description   = %q{A DSL for generating JSON Schemas}
  gem.summary       = %q{A DSL for generating JSON Schemas}
  gem.homepage      = "http://github.com/crystalcommerce/sexy_json_schemas"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
