$LOAD_PATH << './'
require 'csv'
require 'lib/sales_engine/invoice_items_object'
require 'lib/sales_engine/invoices_object'
require 'lib/sales_engine/transactions_object'
require 'lib/sales_engine/item_object'
require 'lib/sales_engine/merchant_object'
require 'lib/sales_engine/customer_object'

class StartupLoader

CSV_OPTIONS = {:headers => true, :header_converters => :symbol}

  # declaring and creating 'loaded_data' for the startuploader class

  def initialize(filename, class_object)
    @target_class = class_object
    @loaded_data = []
    csv_open(filename)
  end

  def loaded_data
    @loaded_data
  end

  def loaded_data=(input)
    @loaded=input
  end
  def csv_open(filename)
    loading_data(CSV.open(filename, CSV_OPTIONS))
  end

  def loading_data(file)
    file.rewind
    @loaded_data = file.collect { |line| @target_class.new(line) }
    return @loaded_data
  end 
end

# invoice_items = StartupLoader.new("data/customers.csv", CustomerObject)
