require 'bundler'
require 'simplecov'

Bundler.require(:default, :test)
SimpleCov.start
require './sales_engine'