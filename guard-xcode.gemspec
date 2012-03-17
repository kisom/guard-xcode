# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "guard-xcode"
  s.version     = "1.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=

  s.authors     = ["Kyle Isom"]
  s.email       = ["coder@kyleisom.net"]
  s.homepage    = "https://github.com/kisom/guard-xcode"
  s.summary     = "Run Xcode builds when source files change."
  s.licenses    = ["ISC", "public domain"]
  s.description = "Build an Xcode project when source files change."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.extra_rdoc_files = [
    "CHANGELOG.md",
    "LICENSE.md",
    "README.md"
  ]

  s.add_runtime_dependency "guard"
  #s.add_development_dependency "rspec"
end
