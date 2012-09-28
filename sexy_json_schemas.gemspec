# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "sexy_json_schemas"
  gem.version       = "0.0.6"
  gem.authors       = ["Donald Plummer", "Michael Xavier"]
  gem.email         = ["donald@crystalcommerce.com", "xavier@crystalcommerce.com"]
  gem.description   = %q{A DSL for generating JSON Schemas}
  gem.summary       = %q{A DSL for generating JSON Schemas}
  gem.homepage      = "http://github.com/crystalcommerce/sexy_json_schemas"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency("rake", "~> 0.9.2")
  gem.add_development_dependency("rspec", "~> 2.11.0")
  gem.add_development_dependency("guard", "~> 1.2.1")
  gem.add_development_dependency("guard-rspec", "~> 1.1.0")
  gem.add_development_dependency("fivemat", "~> 1.1.0")
  gem.add_development_dependency("rb-inotify", "~> 0.8.8")
  gem.add_development_dependency("require_relative", "~> 1.0.3") # for json-schema
  gem.add_development_dependency("json-schema", "~> 1.0.9")
  gem.add_development_dependency("json", "~> 1.7.5")
end
