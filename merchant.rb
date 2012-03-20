$LOAD_PATH << './'
require 'csv'
require 'merchant_objects'


class Merchant

CSV_OPTIONS = {:headers => true, :header_converters => :symbol}

  # declaring and creating 'loaded_data' for the Merchant class 

  def initialize(filename, options = CSV_OPTIONS)
    @@loaded_data = []
    if filename.nil?
      filename = "data/merchants.csv"
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

  # loading the merchants.csv file TO the 'loaded_data' variable
  # within the Merchant class

  def loading_data(file)
    file.rewind
    @@loaded_data = file.collect { |line| Merchant_objects.new(line) }
    # puts @@loaded_data
  end 

  def merchant_name
    @@loaded_data.each do |record| 
      puts record.merchant_name
    end
  end

end

merchants = Merchant.new("data/merchants.csv")
merchants.merchant_name