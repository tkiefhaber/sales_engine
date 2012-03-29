require 'sales_engine/database'
require 'sales_engine/merchant'
require 'sales_engine/customer'
require 'sales_engine/item'
require 'sales_engine/invoice'
require 'sales_engine/invoice_item'
require 'sales_engine/transaction'
require 'bigdecimal'

module SalesEngine
CSV_OPTIONS = {:headers => true, :header_converters => :symbol}
  def self.startup
    load_data
  end

  def self.load_data
    Database.instance.load_data
  end

end