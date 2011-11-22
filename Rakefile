$LOAD_PATH.unshift File.join(File.dirname(__FILE__))
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'test')

# desc "Run tests"
# task :test do
#   # require 'test/sample_test.rb'
#   Dir['test/**/*_test.rb'].each { |file| require file }
# end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features)

require 'rake/testtask'

desc 'Run all tests'
task :test do
  errors = %w(test:units).collect do |task|
    begin
      Rake::Task[task].invoke
      nil
    rescue => e
      task
    end
  end.compact
  abort "Errors running #{errors.inspect}!" if errors.any?
end

namespace :test do
  Rake::TestTask.new(:units) do |t|
    files = FileList['test/**/*_test.rb']

    t.libs << 'test'
    t.verbose = true
    t.test_files = files
  end
end # namespace :test



task :default => [:test, :features]