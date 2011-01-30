require 'rubygems'
require 'rake'
require 'rake/testtask'

desc "Run basic tests"
Rake::TestTask::new "test" do |t|
  t.pattern = "test/tc*.rb"
  t.verbose = true
  t.warning = true
end
