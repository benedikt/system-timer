# Copyright 2008 David Vollbracht & Philippe Hanrigou

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'rake/clean'
require 'rubygems'

CLEAN.include '**/*.o'
CLEAN.include '**/*.so'
CLEAN.include '**/*.bundle'
CLOBBER.include '**/*.log'
CLOBBER.include '**/Makefile'
CLOBBER.include '**/extconf.h'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test SystemTimer'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end
task :test => 'ext/system_timer/libsystem_timer_native.so'

desc 'Generate documentation for SystemTimer.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'SystemTimer'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

file 'ext/system_timer/Makefile' => 'ext/system_timer/extconf.rb' do
  Dir.chdir('ext/system_timer') do
    ruby 'extconf.rb'
  end
end

file 'ext/system_timer/libsystem_timer_native.so' => 'ext/system_timer/Makefile' do
  Dir.chdir('ext/system_timer') do
    pid = fork { exec "make" }
    Process.waitpid pid
  end
  fail "Make failed (status #{m})" unless $?.exitstatus == 0
end

specification = Gem::Specification.load("SystemTimer.gemspec")

desc 'Install the gem into the local gem repository' 
task :install => 'package' do
  sh "gem install ./pkg/#{specification.name}-#{specification.version}.gem"
end

Rake::GemPackageTask.new(specification) do |package|
	 package.need_zip = false
	 package.need_tar = false
end

desc "Publish RDoc on Rubyforge website"
task :publish_rdoc => :rdoc do
  sh "scp -r rdoc/* #{ENV['USER']}@rubyforge.org:/var/www/gforge-projects/systemtimer"
end
