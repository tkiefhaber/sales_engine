require 'csv'

module SalesEngine

  class StartupLoader

  attr_accessor :target_class, :loaded_data

  CSV_OPTIONS = {:headers => true, :header_converters => :symbol}

    def initialize(filename, class_object)
      @loaded_data = []
      csv_open(filename)
    end

    def csv_open(filename)
      loading_data(CSV.open(filename, CSV_OPTIONS))
    end

    def loading_data(file)
      file.rewind
      @loaded_data = file.collect { |line| @target_class.new(line) }
    end 
  end
end