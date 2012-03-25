
require 'csv'
# require '/sales_engine/invoice_items_object'
# require 'invoices_object'
# require 'transactions_object'
# require 'item_object'
# require 'merchant_object'
# require 'customer_object'

module SalesEngine

  class StartupLoader

  attr_accessor :target_class, :loaded_data

  CSV_OPTIONS = {:headers => true, :header_converters => :symbol}

    def initialize(filename, class_object)
      @target_class = class_object
      @loaded_data = []
      csv_open(filename)
    end

    def csv_open(filename)
      # if filename.nil?
      #   puts "Filename is nil; please specify a valid filename, processing otherwise unable to continue"
      #   return @loaded_data
      # end
      loading_data(CSV.open(filename, CSV_OPTIONS))
    end

    def loading_data(file)
      file.rewind
      @loaded_data = file.collect { |line| @target_class.new(line) }
      return @loaded_data
    end 
  end
end