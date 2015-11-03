$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "turbobus/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "turbobus"
  s.version     = Turbobus::VERSION
  s.authors     = ["suruja"]
  s.email       = ["sebstp@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Turbobus."
  s.description = "TODO: Description of Turbobus."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.4"
  s.add_dependency "message_bus", "~> 1.0.0"
  s.add_dependency "railties", "~> 4.2.4"
end
