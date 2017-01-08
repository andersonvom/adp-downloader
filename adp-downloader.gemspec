Gem::Specification.new do |s|
  s.name        = "adp-downloader"
  s.version     = "0.1.0"
  s.executables << "adp-downloader"
  s.date        = "2017-01-06"
  s.summary     = "ADP pay statements / pay stubs downloader"
  s.description = "This app incrementally downloads ADP pay statments from ADP's iPay"
  s.authors     = ["Anderson Mesquita"]
  s.email       = "andersonvom@gmail.com"
  s.files       = Dir[
    "adp-downloader.gemspec",
    "{bin,lib,static}/**/*",
    "{Gem,Rake}file*",
    "*.md",
  ]
  s.homepage    = "http://rubygems.org/gems/adp-downloader"
  s.license     = "MIT"
end
