require "rubygems/package_task"

SPEC = eval(File.read("adp-downloader.gemspec"))

Gem::PackageTask.new(SPEC) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
end

task :default => [:gem]

task :install => [:gem] do
  sh "gem install #{gem_path}"
end

task :publish => [:gem] do
  sh "gem push #{gem_path}"
end

def gem_path
  "pkg/adp-downloader-#{SPEC.version}.gem"
end
