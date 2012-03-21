$LOAD_PATH << './'
require 'csv'
require 'Invoices_objects'


class Invoices

CSV_OPTIONS = {:headers => true, :header_converters => :symbol}

  # declaring and creating 'loaded_data' for the Invoices class 

  def initialize(filename, options = CSV_OPTIONS)
    @@loaded_data = []
    if filename.nil?
      filename = "data/invoices.csv"
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

  # loading the invoices.csv file TO the 'loaded_data' variable
  # within the Merchant class

  def loading_data(file)
    file.rewind
    @@loaded_data = file.collect { |line| Invoices_objects.new(line) }
    # puts @@loaded_data
  end 

  def i_invoices_id
    @@loaded_data.each do |record| 
      puts record.i_invoices_id
    end
  end

end

invoices = Invoices.new("data/invoices.csv")
invoices.i_invoices_id