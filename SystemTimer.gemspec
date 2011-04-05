SYSTEM_TIMER_VERSION = "1.2.1"
SYSTEM_TIMER_GEM_NAME = "SystemTimer"

Gem::Specification.new do |s|
  s.name = SYSTEM_TIMER_GEM_NAME
  s.summary = "Set a Timeout based on signals, which are more reliable than Timeout. Timeout is based on green threads."
  s.version = SYSTEM_TIMER_VERSION
  s.authors = ["Philippe Hanrigou", "David Vollbracht"]

  if Object.const_defined? :RUBY_PLATFORM
    platform = RUBY_PLATFORM
  else
    platform = PLATFORM
  end

  if ENV['PACKAGE_FOR_WIN32'] || platform =~ /w(in)?32/
    s.platform = Gem::Platform::RUBY
    s.files = ['lib/system_timer.rb', 'lib/system_timer_stub.rb']
  else
    s.platform = Gem::Platform::RUBY
    s.files = [ "COPYING", "LICENSE", "ChangeLog"] + 
                Dir.glob('ext/**/*.c') + 
                Dir.glob('ext/**/*.rb') + 
                Dir.glob('lib/**/*.rb') + 
                Dir.glob('test/**/*.rb')
    s.autorequire = "system_timer"
    s.extensions = ["ext/system_timer/extconf.rb"]
  end  
  s.require_path = "lib"
  s.rdoc_options << '--title' << 'SystemTimer' << '--main' << 'README' << '--line-numbers'

  s.extra_rdoc_files = ['README']
	s.test_file = "test/all_tests.rb"
	s.rubyforge_project = "systemtimer"
end