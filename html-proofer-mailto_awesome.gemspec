lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'html/proofer/mailto_awesome/version'

Gem::Specification.new do |spec|
  spec.name = 'html-proofer-mailto_awesome'
  spec.version = MailtoAwesome::VERSION
  spec.authors = ['William Entriken']
  spec.email = 'github.com@phor.net'

  spec.summary = 'Checker for mailto links'
  spec.description = 'A custom html-proofer test that makes your mailto links awesome'
  spec.homepage = 'https://github.com/fulldecent/html-proofer-mailto_awesome'
  spec.license = 'MIT'
  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0.2"
  spec.add_development_dependency "rake", "~> 13.0.6"
  spec.add_runtime_dependency 'html-proofer', '~> 5.0', '>= 5.0.4'
  spec.add_development_dependency 'rspec', '~> 3.12', '>= 3.12.0'
  spec.add_development_dependency 'vcr', '~> 6.1', '>= 6.1.0'
  spec.add_development_dependency 'timecop', '~> 0.9', '>= 0.9.6'
end
