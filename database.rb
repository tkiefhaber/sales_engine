$LOAD_PATH << './'
require 'startup_loader'
require 'singleton'

class Database
  include Singleton

  attr_accessor :invoice_items_data, :invoices_data, :transactions_data,
                :items_data, :merchants_data, :customers_data

  def initialize
    @invoice_items_data   = StartupLoader.new("data/invoice_items.csv", InvoiceItemsObjects).loaded_data
    @invoices_data        = StartupLoader.new("data/invoices.csv", InvoicesObjects).loaded_data
    @transactions_data    = StartupLoader.new("data/transactions.csv", TransactionsObjects).loaded_data
    @items_data           = StartupLoader.new("data/items.csv", ItemObject).loaded_data
    @merchants_data       = StartupLoader.new("data/merchants.csv", MerchantObject).loaded_data
    @customers_data       = StartupLoader.new("data/customers.csv", CustomerObject).loaded_data
  end

  def query
    @merchants_data.each do |record| 
      puts record.m_merchant_name
    end
  end

end