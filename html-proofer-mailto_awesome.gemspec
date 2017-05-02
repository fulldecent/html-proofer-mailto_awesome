require 'rake'
Gem::Specification.new do |s|
  s.name = 'html-proofer-mailto_awesome'
  s.version = '0.1'
  s.date = '2017-02-05'
  s.summary = 'Custom html-proofer test'
  s.description = 'A custom html-proofer test that makes your mailto links awesome'
  s.authors = ['William Entriken']
  s.email = 'github.com@phor.net'
  s.files = FileList['lib/*.rb']
  s.homepage = 'https://github.com/fulldecent/html-proofer-mailto_awesome'
  s.license = 'MIT'

  s.add_runtime_dependency 'html-proofer', '~> 3.0', '>= 3.0.0'
end
