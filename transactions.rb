$LOAD_PATH << './'
require 'csv'
require 'transactions_objects'


class Transactions

CSV_OPTIONS = {:headers => true, :header_converters => :symbol}

  # declaring and creating 'loaded_data' for the Invoices class 

  def initialize(filename, options = CSV_OPTIONS)
    @loaded_data = []
    if filename.nil?
      filename = "data/transactions.csv"
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

  # loading the invoice_items.csv file TO the 'loaded_data' variable
  # within the invoice items class

  def loading_data(file)
    file.rewind
    @loaded_data = file.collect { |line| Transactions_objects.new(line) }
    # puts @loaded_data
  end 

  def t_transactions_id
    @loaded_data.each do |record| 
      puts record.t_transactions_id
    end
  end

end

transactions = Transactions.new("data/transactions.csv")
transactions.t_transactions_id