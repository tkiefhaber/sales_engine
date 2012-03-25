require 'singleton'

module SalesEngine

  class Database
    include Singleton

    attr_accessor :invoice_items_data, :invoices_data, :transactions_data, :items_data, :merchants_data, :customers_data

    def initialize
      @invoice_items_data   = SalesEngine::StartupLoader.new("data/invoice_items.csv", InvoiceItem).loaded_data
      @invoices_data        = SalesEngine::StartupLoader.new("data/invoices.csv", Invoice).loaded_data
      @transactions_data    = SalesEngine::StartupLoader.new("data/transactions.csv", Transaction).loaded_data
      @items_data           = SalesEngine::StartupLoader.new("data/items.csv", Item).loaded_data
      @merchants_data       = SalesEngine::StartupLoader.new("data/merchants.csv", Merchant).loaded_data
      @customers_data       = SalesEngine::StartupLoader.new("data/customers.csv", Customer).loaded_data
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