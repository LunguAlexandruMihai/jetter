$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "jetter/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "jetter"
  spec.version     = Jetter::VERSION
  spec.authors     = ["Lungu Alexandru-Mihai"]
  spec.email       = ["lungualexandrumihai@gmail.com"]
  spec.homepage    = "https://github.com/LunguAlexandruMihai/jetter"
  spec.summary     = "Jet API for Ruby on Rails."
  spec.description = "Jet API wrapper for ruby on rails"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 5.2.2"
  gem.add_runtime_dependency 'rest-client', '~> 2.0'
  gem.add_runtime_dependency 'oj', '~> 2.18'
end
