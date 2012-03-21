$LOAD_PATH << './'
require 'csv'
require 'item_object'

class Item

CSV_OPTIONS = {:headers => true, :header_converters => :symbol}

  # declaring and creating 'loaded_data' for the item class 

  def initialize(filename, options = CSV_OPTIONS)
    @@loaded_data = []
    if filename.nil?
      filename = "data/items.csv"
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

  # loading the items.csv file TO the 'loaded_data' variable
  # within the item class

  def loading_data(file)
    file.rewind
    @@loaded_data = file.collect { |line| Item_Object.new(line) }
  end 

  def item_name
    @@loaded_data.each do |record| 
      puts record.item_name
    end
  end

end

items = Item.new("data/items.csv")
items.item_name