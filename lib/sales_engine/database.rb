require 'singleton'
require 'csv'

module SalesEngine

  class Database
    include Singleton

    attr_accessor :invoice_items_data, :invoices_data, 
                  :transactions_data, :items_data, 
                  :merchants_data, :customers_data

    def load_data
      @invoice_items_data   = load("data/invoice_items.csv", InvoiceItem)
      @invoices_data        = load("data/invoices.csv", Invoice)
      @transactions_data    = load("data/transactions.csv", Transaction)
      @items_data           = load("data/items.csv", Item)
      @merchants_data       = load("data/merchants.csv", Merchant)
      @customers_data       = load("data/customers.csv", Customer)
    end

    def load(filename, target_class)
      file = csv_open(filename)
      file.rewind
      file.collect { |line| target_class.new(line) }
    end

    def csv_open(filename)
      CSV.open(filename, CSV_OPTIONS)
    end

    def add_merchant(merchant)
      self.merchants_data << merchant
    end

    def add_invoice(invoice)
      self.invoices_data << invoice
    end

    def add_customer(customer)
      self.customers_data << customer
    end

    def add_item(item)
      self.items_data << item
    end

    def add_invoice_item(invoice_item)
      self.invoice_items_data << invoice_item
    end

    def add_transaction (transaction)
      self.transactions_data << transaction
    end

  end
end