# encoding: UTF-8
lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'spree_group_buy/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_group_buy'
  s.version     = SpreeGroupBuy.version
  s.summary     = 'Spree group buy extension'
  s.description = 'Spree group buy extension'
  s.required_ruby_version = '>= 2.3.3'

  s.author    = 'Everymarket'
  s.email     = 'josh@everymarket.com'
  s.homepage  = 'https://github.com/joshyan/spree_group_buy'
  s.license = 'BSD-3-Clause'

  s.files       = `git ls-files`.split("\n").reject { |f| f.match(/^spec/) && !f.match(/^spec\/fixtures/) }
  s.require_path = 'lib'
  s.requirements << 'none'

  spree_version = '>= 3.2.0', '< 5.0'
  s.add_dependency 'spree_core', spree_version
  s.add_dependency 'spree_api', spree_version
  s.add_dependency 'spree_backend', spree_version
  s.add_dependency 'spree_extension'
  s.add_dependency 'deface', '~> 1.0'

  s.add_development_dependency 'spree_dev_tools'
end
