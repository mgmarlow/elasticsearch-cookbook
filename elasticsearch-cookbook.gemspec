# frozen_string_literal: true

lib = File.expand_path("../examples", __FILE__) # rubocop:disable Style/ExpandPathArguments
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "elasticsearch-cookbook"
  spec.version       = "0.0.1"
  spec.authors       = ["Graham Marlow"]
  spec.email         = ["mgmarlow@hey.com"]

  spec.summary       = "Elasticsearch Cookbook"
  spec.description   = "Notes and examples for Elasticsearch"
  spec.homepage      = "https://github.com/mgmarlow/elasticsearch-cookbook"

  spec.require_paths = ["examples"]

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.add_dependency 'elasticsearch'
  spec.add_dependency 'elasticsearch-dsl'
  spec.add_dependency 'pry'
  spec.add_dependency 'pry-byebug'
end
