# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rack-timeout"
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Caio Chassot"]
  s.date = "2011-07-13"
  s.email = "dev@caiochassot.com"
  s.homepage = "http://github.com/kch/rack-timeout"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Abort requests that are taking too long"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
