require 'rubygems'
require 'rake'
require 'rake/testtask'

task :default => [:test]

desc 'Tests'
Rake::TestTask.new(:test) do |t|
	t.libs << "test"
	t.test_files = Dir.glob("test/**/test_*.rb")
	t.verbose = true
end

