# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'make_model_searchable/version'

Gem::Specification.new do |spec|
  spec.name          = "make_model_searchable"
  spec.version       = MakeModelSearchable::VERSION
  spec.authors       = ["8parth"]
  spec.email         = ["parthmodi54@yahoo.com"]

  spec.summary       = %q{Adds simple search functionality to your models.}
  spec.description   = %q{Moduler solution to add search functionality for selected fields.}
  spec.homepage      = "https://github.com/8parth/make_model_searchable"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'activerecord', '~> 3.0', '>= 3.0.0'
  spec.add_development_dependency 'activesupport', '~> 3.0', '>= 3.0.0'
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
