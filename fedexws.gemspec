Gem::Specification.new do |s|
  s.name        = "fedexws"
  s.version     = "0.0.5"
  s.summary     = "FedEx Web Services"
  s.description = "A library to use FedEx Web Services"
  s.authors     = ["Astr0Surf3r"]
  s.email       = "astr0surf3r@gmail.com"
  s.files       = Dir.glob("lib/**/*") + ["README.md"]
  s.require_paths = ["lib"]
  s.homepage    = "https://github.com/Astr0surf3r/fedexws"
  s.license       = "MIT"
  
  s.add_development_dependency 'rails', '~> 6.0.0'
  s.add_development_dependency 'thor', '~> 1.0.0'
  s.add_development_dependency 'net/http', '~> 0.1.0'
  s.add_development_dependency 'rspec', '~> 3.9.0'
end
