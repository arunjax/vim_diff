# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "vim_diff/version"

Gem::Specification.new do |s|
  s.name        = "vim_diff"
  s.version     = VimDiff::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Arun Kumar Arjunan"]
  s.email       = ["arun.immanuel1608@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Generate diff to HTML}
  s.description = %q{vim_diff gem uses vim functionality to convert a normal diff to HTML}

  s.rubyforge_project = "vim_diff"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
