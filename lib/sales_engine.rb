$LOAD_PATH.unshift("./")
$LOAD_PATH.unshift("../")
require 'sales_engine/database'
require 'sales_engine/merchant'
require 'sales_engine/customer'
require 'sales_engine/item'
require 'sales_engine/invoice'
require 'sales_engine/invoice_item'
require 'sales_engine/transaction'
require 'sales_engine/startup_loader'

module SalesEngine
CSV_OPTIONS = {:headers => true, :header_converters => :symbol}
  def self.startup
    load_data
    # Merchant.most_revenue(10).each do |merchant|
    #   puts "MERCHANT: #{merchant.id}, REVENUE:#{merchant.revenue}"
    # end
    # Merchant.most_items(10).each do |merchant|
    #   puts "MERCHANT: #{merchant.id}, ITEMS:#{merchant.items_sold}"
    # end
    m = Merchant.random
    c = m.favorite_customer
    puts c 
    puts c.successful_transactions.size
  end

  def self.load_data
    Database.instance.load_data
  end
  # startup :db

  # class SalesEngineStarter
  #   db = Database.instance
  #   db.query
  # end 

end