# $LOAD_PATH << './'
# require 'startup_loader'
require 'singleton'

module SalesEngine

  class Database
    include Singleton

    attr_accessor :invoice_items_data, :invoices_data, :transactions_data, :items_data, :merchants_data, :customers_data

    def initialize
      @invoice_items_data   = SalesEngine::StartupLoader.new("data/invoice_items.csv", InvoiceItemsObject).loaded_data
      @invoices_data        = SalesEngine::StartupLoader.new("data/invoices.csv", InvoicesObject).loaded_data
      @transactions_data    = SalesEngine::StartupLoader.new("data/transactions.csv", TransactionsObject).loaded_data
      @items_data           = SalesEngine::StartupLoader.new("data/items.csv", ItemObject).loaded_data
      @merchants_data       = SalesEngine::StartupLoader.new("data/merchants.csv", MerchantObject).loaded_data
      @customers_data       = SalesEngine::StartupLoader.new("data/customers.csv", CustomerObject).loaded_data
    end

    # def merchants_data
    #   @merchants_data
    # end

    # def query
    #   @merchants_data.each do |record| 
    #     puts record.m_merchant_name
    #   end
    # end

  end
end