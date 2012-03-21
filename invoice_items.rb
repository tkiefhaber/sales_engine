$LOAD_PATH << './'
require 'csv'
require 'invoice_items_objects'


class Invoice_items

CSV_OPTIONS = {:headers => true, :header_converters => :symbol}

  # declaring and creating 'loaded_data' for the Invoices class 

  def initialize(filename, options = CSV_OPTIONS)
    @@loaded_data = []
    if filename.nil?
      filename = "data/invoice_items.csv"
    end
    file = (CSV.open(filename, options))
    loading_data(file)
  end

  def self.loaded_data
    @@loaded_data
  end

  def self.loaded_data=(input)
    @@loaded=input
  end

  # loading the invoice_items.csv file TO the 'loaded_data' variable
  # within the invoice items class

  def loading_data(file)
    file.rewind
    @@loaded_data = file.collect { |line| Invoice_items_objects.new(line) }
    # puts @@loaded_data
  end 

  def it_invoice_items_id
    @@loaded_data.each do |record| 
      puts record.it_invoice_items_id
    end
  end

end

invoice_items = Invoice_items.new("data/invoice_items.csv")
invoice_items.it_invoice_items_id