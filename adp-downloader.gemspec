# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "adp-downloader/version"

Gem::Specification.new do |s|
  s.name          = "adp-downloader"
  s.version       = ADPDownloader::VERSION
  s.date          = `git show -s --format=%cI head | cut -d 'T' -f1`
  s.authors       = ["Anderson Mesquita (andersonvom)"]
  s.email         = "andersonvom@gmail.com"

  s.summary       = %q{ADP pay statement / pay stub downloader from MyADP}
  s.description   = %q{This app incrementally downloads ADP pay statements (pay stubs) from MyADP}
  s.homepage      = "http://rubygems.org/gems/adp-downloader"
  s.license       = "GPL-3.0"

  s.files         = `git ls-files -z`.split("\x0")
  s.bindir        = "bin"
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "mechanize", "~> 2.7"
  s.add_dependency "parallel", "~> 1.10"
  s.add_development_dependency "bundler", "~> 1.13"
  s.add_development_dependency "rake", "~> 10.0"
end
