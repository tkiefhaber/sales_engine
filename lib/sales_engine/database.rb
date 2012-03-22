$LOAD_PATH << './'
require 'lib/sales_engine/startup_loader'
require 'singleton'

class Database
  include Singleton

  attr_accessor :invoice_items_data, :invoices_data, :transactions_data, :items_data, :merchants_data, :customers_data

  def initialize
    @invoice_items_data   = StartupLoader.new("data/invoice_items.csv", InvoiceItemsObject).loaded_data
    @invoices_data        = StartupLoader.new("data/invoices.csv", InvoicesObject).loaded_data
    @transactions_data    = StartupLoader.new("data/transactions.csv", TransactionsObject).loaded_data
    @items_data           = StartupLoader.new("data/items.csv", ItemObject).loaded_data
    @merchants_data       = StartupLoader.new("data/merchants.csv", MerchantObject).loaded_data
    @customers_data       = StartupLoader.new("data/customers.csv", CustomerObject).loaded_data
  end

  def query
    @customers_data.each do |record| 
      puts record.c_customer_fname + " " + record.c_customer_lname
    end
  end

end