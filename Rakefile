require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "binary_search"
    s.summary = "Binary search and index methods for Ruby Arrays."
    s.email = "tbmcmullen@gmail.com"
    s.homepage = "http://github.com/tyler/binary_search"
    s.description = s.summary
    s.authors = ["Tyler McMullen", "Michael Graff"]
    s.files = Dir.glob("{ext,lib}/**/*.{c,rb}")
    s.extensions = ['ext/binary_search_ext/extconf.rb']
    s.require_paths << 'ext'
  end
  Jeweler::RubygemsDotOrgTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require 'rake/extensiontask'
Rake::ExtensionTask.new('binary_search_ext')

require 'rake/testtask'
Rake::TestTask.new(:test_native) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_native*.rb'
  test.verbose = true
end

Rake::TestTask.new(:test_pure) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_pure*.rb'
  test.verbose = true
end

task :test => :test_native
task :test_native => :compile
task :test => :test_pure

require 'yard'
YARD::Rake::YardocTask.new

task :default => :test
