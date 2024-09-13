require "rake/testtask"
require "rubocop/rake_task"

desc "Run Rubocop lint checks"
task :rubocop do
  RuboCop::RakeTask.new
end

desc "Run Chefstyle lint checks"
task :lint do
  require "chefstyle"
  require "rubocop/rake_task"
  RuboCop::RakeTask.new(:lint) do |task|
    task.options += ["--display-cop-names", "--no-color", "--parallel"]
  end
rescue LoadError
  puts "rubocop is not available. Install the rubocop gem to run the lint tests."
end

Rake::TestTask.new do |t|
  t.libs << "lib"
  t.libs << File.join("test", "unit")
  t.warning = false
  t.verbose = true
  t.pattern = File.join("test", "unit", "**", "*_test.rb")
end

namespace :test do
end
