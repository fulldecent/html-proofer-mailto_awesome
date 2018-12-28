lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rake'
require 'mailto_awesome/version'

Gem::Specification.new do |spec|
  spec.name = 'html-proofer-mailto_awesome'
  spec.version = MailtoAwesome::VERSION
  spec.authors = ['William Entriken']
  spec.email = 'github.com@phor.net'

  spec.summary = 'Checker for mailto links'
  spec.description = 'A custom html-proofer test that makes your mailto links awesome'
  spec.homepage = 'https://github.com/fulldecent/html-proofer-mailto_awesome'
  spec.license = 'MIT'
 
  spec.files = FileList['lib/*.rb']
 
  spec.add_runtime_dependency 'html-proofer', '~> 3.0', '>= 3.9.0'
  spec.add_runtime_dependency 'rake', '~> 12.0', '>= 12.0.0'
  spec.add_development_dependency 'rspec', '~> 3.5', '>= 3.5.0'
  spec.add_development_dependency 'vcr', '~> 3.0', '>= 3.0.3'
  spec.add_development_dependency 'timecop', '~> 0.8', '>= 0.8.1'
end
