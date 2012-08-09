Gem::Specification.new do |s|
  s.name        = "oration"
  s.version     = "0.0.4"
  s.authors     = ["Chris Bunch", "Andres Riofrio"]
  s.email       = "appscale_community@googlegroups.com"
  s.homepage    = "http://appscale.cs.ucsb.edu"
  s.summary     = "Generates Cicero-ready Google App Engine apps from regular code"
  s.description = %{
    Oration converts a function written in Python or Go into a Google App Engine
    application that conforms to the Cicero API, allowing the given function to
    be automatically executed over Google App Engine or AppScale in an
    embarrassingly parallel fashion.
  }

  s.add_dependency "optiflag"
  s.add_dependency "mustache"
  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "json"
  s.add_development_dependency "rest-client"
  s.add_development_dependency "require_all"

  s.files        = Dir.glob("{bin,lib,templates,test}/**/*") + %w(LICENSE README.md)
  s.executables  = ['oration']
  s.default_executable = 'oration'
  s.require_path = 'lib'
end
