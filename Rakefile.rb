require 'rubygems'
require 'rake'
require 'rake/testtask'
# TODO(mtomczak): Temporary hack while I figure out gem paths
$: << File.dirname(__FILE__)+"/lib"
Gem.path << File.dirname(__FILE__)

desc "Run basic tests"
Rake::TestTask::new "test" do |t|
  t.pattern = "lib/belphanior/servant/homenetwork/test/tc*.rb"
  t.verbose = true
  t.warning = true
end

desc "Launch the servant (for testing)"
task :servant do |t|
  puts Gem.path
  puts '---'
  puts $:
  sh "bin/belphanior-x10-servant"
end
