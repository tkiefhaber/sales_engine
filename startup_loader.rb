$LOAD_PATH << './'
require 'csv'
require 'invoice_items_objects'
require 'invoices_objects'
require 'transactions_objects'
require 'item_object'
require 'merchant_object'
require 'customer_object'

class StartupLoader

CSV_OPTIONS = {:headers => true, :header_converters => :symbol}

  # declaring and creating 'loaded_data' for the startuploader class

  def initialize(filename, class_object)
    @target_class = class_object
    @loaded_data = []
    filename_check(filename)
    file = (CSV.open(filename, CSV_OPTIONS))
    loading_data(file)
  end

  def filename_check(filename)
    if filename.nil?
      filename = "data/invoice_items.csv"
    end
    return filename
  end

  def loaded_data
    @loaded_data
  end

  def loaded_data=(input)
    @loaded=input
  end

  # loading the invoice_items.csv file TO the 'loaded_data' variable
  # within the invoice items class

  def loading_data(file)
    file.rewind
    @loaded_data = file.collect { |line| @target_class.new(line) }
    return @loaded_data
  end 
end

# invoice_items = StartupLoader.new("data/customers.csv", CustomerObject)
