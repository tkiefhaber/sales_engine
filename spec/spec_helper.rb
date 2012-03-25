require 'bundler'
require 'simplecov'
Bundler.require(:default, :test)
SimpleCov.start do
  add_filter "/spec/"
end

require 'sales_engine'

SalesEngine.startup