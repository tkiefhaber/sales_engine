require 'sales_engine/database'
require 'sales_engine/merchant'
require 'sales_engine/customer'
require 'sales_engine/item'
require 'sales_engine/invoices'
require 'sales_engine/invoice_items'
require 'sales_engine/transactions'
require 'sales_engine/merchant_object'
require 'sales_engine/invoices_object'
require 'sales_engine/invoice_items_object'
require 'sales_engine/item_object'
require 'sales_engine/customer_object'
require 'sales_engine/transactions_object'
require 'sales_engine/startup_loader'

module SalesEngine

  def self.startup
    db = SalesEngine::Database.instance
    # db.query
    # rm = SalesEngine::Merchant.find_by_merchant_name(#{parameter})
    # puts rm.m_merchant_name
  end

  # startup :db

  # class SalesEngineStarter
  #   db = Database.instance
  #   db.query
  # end

end