# encoding: utf-8

def self.add_to_path path
 path = File.expand_path "../#{path}/", __FILE__

 $:.unshift path unless $:.include? path
end

add_to_path 'lib'

require 'rspec_flake'

Gem::Specification.new do |s|
  # 1.8.x is not supported
  s.required_ruby_version = '>= 1.9.3'

  s.name = 'rspec_flake'
  s.version = RSpecFlake::VERSION
  s.date = RSpecFlake::DATE
  s.license = 'http://www.apache.org/licenses/LICENSE-2.0.txt'
  s.description = s.summary = 'Measure flaky RSpec tests'
  s.description += '.' # avoid identical warning
  s.authors = s.email = %w(code@bootstraponline.com)
  s.homepage = 'https://github.com/bootstraponline/rspec_flake'
  s.require_paths = %w(lib)

  s.add_runtime_dependency 'chronic_duration', '~> 0.10.2'
  s.add_runtime_dependency 'posix-spawn', '~> 0.3.9'
  s.add_runtime_dependency 'xml-simple', '~> 1.1.4'

  s.add_development_dependency 'thor', '~> 0.19.1'
  s.add_development_dependency 'appium_thor', '~> 0.0.7'
  s.add_development_dependency 'pry', '~> 0.10.1'
  s.add_development_dependency 'awesome_print', '~> 1.6.1'

  s.executables = %w(rspec_flake)
  s.files = `git ls-files`.split "\n"
end
