require "rake/testtask"
require "rubocop/rake_task"

begin
  require "chefstyle"
  require "rubocop/rake_task"
  desc "Run Chefstyle tests"
  RuboCop::RakeTask.new(:style) do |task|
    task.options += %w{ --display-cop-names --no-color }
  end
rescue LoadError
  puts "chefstyle gem is not installed. bundle install first to make sure all dependencies are installed."
end

Rake::TestTask.new(:test) do |t|
  t.libs << "lib"
  t.libs << File.join("test", "unit")
  t.warning = false
  t.verbose = true
  t.pattern = File.join("test", "**", "*_test.rb")
end
