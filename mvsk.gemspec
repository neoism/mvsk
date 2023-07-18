require File.expand_path('../lib/musk/version', __FILE__)

Gem::Specification.new do |s|
  s.name       = 'mvsk'
  s.version    = Musk::VERSION
  s.summary    = 'A simple programming language'
  s.authors    = 'razeos at tossdev'
  s.files      = Dir['lib/**/*']
  s.license    = 'MIT'
  s.executable = 'mvsk'

  s.add_dependency 'pastel', '~> 0.8.0'
end
