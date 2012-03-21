$LOAD_PATH << './'
require 'csv'
require 'invoice_items_objects'
require 'startup_loader'

class InvoiceItemsNew

  def initialize
    @invoice_item_data = StartupLoader.new("data/invoice_items.csv", InvoiceItemsObjects).loaded_data
    # puts @invoice_item_data.loaded_data
  end

  def ii_invoice_items_id
    @invoice_item_data.each do |record| 
      puts record.ii_invoice_items_id
    end
  end
end

invoice_items = InvoiceItemsNew.new
invoice_items.ii_invoice_items_id