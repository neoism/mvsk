require File.expand_path('../lib/liz/version', __FILE__)

Gem::Specification.new do |s|
  s.name       = 'lizism'
  s.version    = Liz::VERSION
  s.summary    = 'A simple programming language'
  s.authors    = 'razeos at tossdev'
  s.files      = Dir['lib/**/*']
  s.license    = 'MIT'

  s.add_dependency 'pastel', '~> 0.8.0'
  s.add_dependency 'clamp', '~> 1.3'
end
