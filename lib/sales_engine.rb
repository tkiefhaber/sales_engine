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
require 'bigdecimal'

module SalesEngine
CSV_OPTIONS = {:headers => true, :header_converters => :symbol}
  def self.startup
    load_data

    # puts Merchant.find_by_name("Johns Inc")
    # Merchant.most_revenue(10).each do |merchant|
    #   puts "MERCHANT: #{merchant.id}, REVENUE:#{merchant.revenue}"
    # end
    # Merchant.most_items(10).each do |merchant|
    #   puts "MERCHANT: #{merchant.id}, ITEMS:#{merchant.items_sold}"
    # end
    # m = Merchant.random
    # puts m.revenue(Date.parse("2012-02-15"))
    # Merchant.most_revenue(10).each do |m|
    #   puts "MERCHANT: #{m.id}, REVENUE:#{m.revenue}"
    # end 
    # c = m.favorite_customer
    # puts m.name
    # puts c.first_name
    # puts c.invoices_with_successful_transactions.size

    # Item.most_revenue(10).each do |item|
    #   puts "ITEM: #{item.id}, REVENUE: #{item.revenue}"
    # end

    # Item.most_items(10).each do |item|
    #   puts "ITEM: #{item.id}, ITEMS_SOLD #{item.items_sold}"
    # end

    # i = Item.random
    # puts i.best_day

    # c = Customer.random
    # puts c.first_name
    # puts c.favorite_merchant.name
    puts invoice = Invoice.create(:customer => Customer.random, 
                                  :merchant => Merchant.random, 
                                  :status => "shipped", 
                                  :items => [Item.random, Item.random, Item.random])
    puts t = invoice.charge(:credit_card_number => "4444333322221111",
                        :credit_card_expiration => "10/13", 
                        :result => "success")
    # i = Invoice.random
    # i.find_new_invoice_id

    # i = Invoice.create
    # Invoice.add_invoice(i)
    # Invoice.find_by_id(i.id)
  end

  def self.load_data
    Database.instance.load_data
  end

end