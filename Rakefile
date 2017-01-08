require 'rubygems/package_task'

task :default => [:gem]

spec = eval(File.read('adp-downloader.gemspec'))
Gem::PackageTask.new(spec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
end
