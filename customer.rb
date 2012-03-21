$LOAD_PATH << './'
require 'csv'
require 'customer_object'


class Customer

CSV_OPTIONS = {:headers => true, :header_converters => :symbol}

  # declaring and creating 'loaded_data' for the customer class 

  def initialize(filename, options = CSV_OPTIONS)
    @loaded_data = []
    if filename.nil?
      filename = "data/customers.csv"
    end
    file = (CSV.open(filename, options))
    loading_data(file)
  end

  def self.loaded_data
    @loaded_data
  end

  def self.loaded_data=(input)
    @loaded=input
  end

  # loading the customers.csv file TO the 'loaded_data' variable
  # within the customer class

  def loading_data(file)
    file.rewind
    @loaded_data = file.collect { |line| Customer_Object.new(line) }
  end 

  def c_customer_name
    @loaded_data.each do |record| 
      puts record.c_customer_fname + " " + record.c_customer_lname
    end
  end

end

customers = Customer.new("data/customers.csv")
customers.c_customer_name