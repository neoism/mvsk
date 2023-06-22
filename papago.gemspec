require File.expand_path('../lib/papago/version', __FILE__)

Gem::Specification.new do |s|
  s.name       = 'papago'
  s.version    = Papago::VERSION
  s.summary    = 'A simple command-line translator'
  s.homepage   = 'https://papago.vercel.app'
  s.authors    = 'razeos at tossdev'
  s.files      = Dir['lib/**/*']
  s.license    = 'MIT'
  s.executable = 'papago'

  s.add_dependency 'mercenary', '~> 0.4.0'
  s.add_dependency 'tty-config', '~> 0.6.0'
  s.add_dependency 'tty-prompt', '~> 0.23.1'
  s.add_dependency 'dolphin_kit', '~> 1.0'
  s.add_dependency 'lolcat', '~> 100.0'
  s.add_dependency 'treely', '~> 1.0'
  s.add_dependency 'http', '~> 5.1'
end
