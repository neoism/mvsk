require File.expand_path('../lib/onda/version', __FILE__)

Gem::Specification.new do |s|
  s.name       = 'onda'
  s.version    = Onda::VERSION
  s.summary    = 'A simple programming language'
  s.authors    = 'razeos at tossdev'
  s.files      = Dir['lib/**/*']
  s.license    = 'MIT'
end
