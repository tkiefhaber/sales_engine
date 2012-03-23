# $LOAD_PATH << './'
require 'csv'
# require '/sales_engine/invoice_items_object'
# require 'invoices_object'
# require 'transactions_object'
# require 'item_object'
# require 'merchant_object'
# require 'customer_object'

module SalesEngine

  class StartupLoader

  CSV_OPTIONS = {:headers => true, :header_converters => :symbol}

    # declaring and creating 'loaded_data' for the startuploader class

    def initialize(filename, class_object)
      @target_class = class_object
      @loaded_data = []
      csv_open(filename)
    end

    def target_class
      @target_class
    end

    def target_class=(input)
      @target_class=input
    end

    def loaded_data
      @loaded_data
    end

    def loaded_data=(input)
      @loaded_data=input
    end

    def csv_open(filename)
      if filename.nil?
        puts "Filename is nil; please specify a valid filename, processing otherwise unable to continue"
        return @loaded_data
      end
      loading_data(CSV.open(filename, CSV_OPTIONS))
    end

    def loading_data(file)
      file.rewind
      @loaded_data = file.collect { |line| @target_class.new(line) }
      return @loaded_data
    end 
  end
end