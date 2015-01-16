# encoding: utf-8
require 'rubygems' # gem requires
require 'nokogiri'
require 'xmlsimple'
require 'posix/spawn' # http://rubygems.org/gems/posix-spawn
require 'escape_utils'

# ruby requies
require 'fileutils'

require_relative 'rspec_flake/rspec_flake'
require_relative 'rspec_flake/version'
require_relative 'rspec_flake/convert'
require_relative 'rspec_flake/parse'
require_relative 'rspec_flake/merge'
require_relative 'rspec_flake/stats'
