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
    puts SalesEngine::Merchant.random
    puts SalesEngine::Merchant.find_by_created_at("2012-02-26 20:56:50 UTC").name
    # puts SalesEngine::Customer.find_all_by_first_name("Stone")
  end

  # startup :db

  # class SalesEngineStarter
  #   db = Database.instance
  #   db.query
  # end

end