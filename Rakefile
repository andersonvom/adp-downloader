require "rubygems/package_task"

spec = eval(File.read("adp-downloader.gemspec"))
Gem::PackageTask.new(spec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
end

task :default => [:gem]

task :install => [:gem] do
  gem_path = "pkg/adp-downloader-#{spec.version}.gem"
  sh "gem install #{gem_path}"
end
