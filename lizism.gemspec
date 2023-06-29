require File.expand_path('../lib/liz/version', __FILE__)

Gem::Specification.new do |s|
  s.name       = 'lizism'
  s.version    = Liz::VERSION
  s.summary    = 'A simple programming language'
  s.authors    = 'razeos at tossdev'
  s.files      = Dir['lib/**/*']
  s.license    = 'MIT'
end
