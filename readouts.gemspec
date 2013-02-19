$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "readouts/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "readouts"
  s.version     = Readouts::VERSION
  s.authors     = ["Hank Beaver", "Obie Fernandez"]
  s.email       = ["hbeaver@gmail.com", "obiefernandez@gmail.com"]
  s.homepage    = "https://github.com/blasterpal/readouts"
  s.summary     = "Easily-extensible informational dashboard for useful ops/app information"
  s.description = "Readouts provides a set of useful default metrics and data about your running Rails app. Secondly, it allows easy plugin of your important app information so you can create a singular dashboard for your Dev and Ops team."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.11"
  s.add_dependency "hashie", "~> 1.2.0"
  #s.add_dependency "hashie", "~> 2.0.0"

  s.add_development_dependency 'rspec-rails'
  # s.add_dependency "jquery-rails"
end
