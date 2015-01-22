require 'thor'

class Default < Thor
  desc 'spec', 'Run RSpec tests'
  def spec
    exec 'bundle exec rspec'
  end
end

require 'appium_thor'

Appium::Thor::Config.set do
  gem_name 'rspec_flake'
end
