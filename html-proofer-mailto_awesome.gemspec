# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rake'
require 'mailto_awesome/version'

Gem::Specification.new do |s|
  s.name = 'html-proofer-mailto_awesome'
  s.version = MailtoAwesome::VERSION
  s.date = '2017-02-05'
  s.summary = 'Custom html-proofer test'
  s.description = 'A custom html-proofer test that makes your mailto links awesome'
  s.authors = ['William Entriken']
  s.email = 'github.com@phor.net'
  s.files = FileList['lib/*.rb']
  s.homepage = 'https://github.com/fulldecent/html-proofer-mailto_awesome'
  s.license = 'MIT'

  s.add_runtime_dependency 'html-proofer', '~> 3.0', '>= 3.0.0'

  s.add_development_dependency 'rake'
end
