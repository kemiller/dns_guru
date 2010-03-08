require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/gempackagetask'

task :default => [:test]

desc 'Tests'
Rake::TestTask.new(:test) do |t|
	t.libs << "test"
	t.test_files = Dir.glob("test/**/test_*.rb")
	t.verbose = true
end

PKG_FILES = FileList[
  '[a-zA-Z]*',
  'generators/**/*',
  'lib/**/*',
  'rails/**/*',
  'tasks/**/*',
  'test/**/*'
]

spec = Gem::Specification.new do |s|
  s.name = "dns_guru"
  s.version = "0.1"
  s.author = "Dns Guru"
  s.email = "ken.miller@gmail.com"
  s.homepage = "http://github.com/kemiller/dns_guru"
  s.platform = Gem::Platform::RUBY
  s.summary = "Parse hostnames into useful information with a routes-like syntax"
  s.files = PKG_FILES.to_a
  s.require_path = "lib"
  s.has_rdoc = false
  s.extra_rdoc_files = ["README"]
end

desc 'Turn this plugin into a gem.'
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end


