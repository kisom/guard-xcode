require "bundler/gem_tasks"
require 'rake/testtask'
require 'rdoc/task'

Rake::TestTask.new do |t|
  t.libs << 'test'
end

RDoc::Task.new do |rdoc|
  rdoc.main = "README.rdoc"
  rdoc.rdoc_files.include("lib/*.rb")
end

desc "Run tests"
task :default => :test