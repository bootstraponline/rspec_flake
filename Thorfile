require 'appium_thor'

Appium::Thor::Config.set do
  gem_name 'rspec_flake'
end

# Must use '::' otherwise Default will point to Thor::Sandbox::Default
# Debug by calling Thor::Base.subclass_files via Pry
#
# https://github.com/erikhuda/thor/issues/484
#
class ::Default < Thor
  desc 'spec', 'Run RSpec tests'
  def spec
    exec 'bundle exec rspec'
  end
end
