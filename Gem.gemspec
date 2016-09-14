# Frozen-string-literal: true
# Copyright: 2015 Forestry.io - MIT License
# Encoding: utf-8

$LOAD_PATH.unshift(File.expand_path("../lib", __FILE__))
require "jekyll/menus/version"

Gem::Specification.new do |spec|
  spec.authors = ["Jordon Bedwell"]
  spec.version = Jekyll::Menus::VERSION
  spec.homepage = "http://github.com/forestryio/jekyll-menus/"
  spec.description = "Menus (site navigation) for your Jekyll website"
  spec.summary = "Menus (navigation) for your very own Jekyll website."
  spec.files = %W(Gemfile) + Dir["lib/**/*"]
  spec.required_ruby_version = ">= 2.1.0"
  spec.email = ["jordon@envygeeks.io"]
  spec.require_paths = ["lib"]
  spec.name = "jekyll-menus"
  spec.has_rdoc = false
  spec.license = "MIT"

  spec.add_runtime_dependency("jekyll", "~> 3.1")
  spec.add_development_dependency(
    "rspec", ">= 3", "< 4"
  )
end
