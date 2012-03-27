require 'sales_engine/database'
require 'sales_engine/merchant'
require 'sales_engine/customer'
require 'sales_engine/item'
require 'sales_engine/invoice'
require 'sales_engine/invoice_item'
require 'sales_engine/transaction'
require 'sales_engine/startup_loader'

module SalesEngine

  def self.startup
    db = SalesEngine::Database.instance
    # db.query
    # puts SalesEngine::Merchant.random
    # puts SalesEngine::Merchant.find_by_created_at("2012-02-26 20:56:50 UTC").name
    # puts SalesEngine::Customer.find_all_by_first_name("Stone")
    # merchant = Merchant.random
    # merchant.items
    # merchant.invoices
    # customer = Customer.random
    # customer.invoices
    # transaction = Database.instance.transactions_data.sample
    # puts transaction.invoice.sample.send(:id)
    # item_example = Item.random
    # puts item_example.merchants.sample.send(:name)
    # item_example = Item.random
    # puts item_example.invoice_items.sample.send(:id)
    # invoice_example = Invoice.random
    # puts invoice_example.invoice_items.sample.send(:invoice_id)
    # puts invoice_example.items
    # puts invoice_example.customer.id
    # invoice_item_example = Database.instance.invoice_items_data.sample
    # puts "This is the invoice id: #{invoice_item_example.invoice.id}"
    # puts "This is hte item id: #{invoice_item_example.item.id}"

  end

  # startup :db

  # class SalesEngineStarter
  #   db = Database.instance
  #   db.query
  # end

end