# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smsbroadcast/version'

Gem::Specification.new do |spec|
  spec.name          = "smsbroadcast"
  spec.version       = Smsbroadcast::VERSION
  spec.authors       = ["sia.s.saj"]
  spec.email         = ["sia.s.saj@gmail.com"]

  spec.summary       = %q{Library to consume smsbroadcast.com.au service.}
  spec.description   = %q{Send & receive sms, and monitor your account with smsbroadcast.com.au.}
  spec.homepage      = %q{https://github.com/siassaj/smsbroadcast.git}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.9.2"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry"
end
