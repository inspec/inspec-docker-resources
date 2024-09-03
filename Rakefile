require 'rake/testtask'
require 'rubocop/rake_task'

desc 'Run Rubocop lint checks'
task :rubocop do
  RuboCop::RakeTask.new
end

desc 'Run robocop linter'
task lint: [:rubocop]

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.libs << File.join('test', 'unit')
  t.warning = false
  t.verbose = true
  t.pattern = File.join('test', 'unit', '**', '*_test.rb')
end

namespace :test do
end