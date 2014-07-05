# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'parse/db/import/version'

Gem::Specification.new do |spec|
  spec.name          = "parse-db-import"
  spec.version       = Parse::Db::Import::VERSION
  spec.authors       = ["JohnMorales"]
  spec.email         = ["jmorales@gmail.com"]
  spec.summary       = %q{A tool to import Parse database exports to activerecord}
  spec.description   = %q{This tool allows you to import your json files exported from Parse to any database supported by activerecord.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_dependency "activerecord"
  spec.add_dependency "commander"
  spec.add_dependency "pg"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
end
