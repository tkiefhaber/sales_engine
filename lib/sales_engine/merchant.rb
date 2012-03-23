module SalesEngine

  class Merchant

    def results
      @results
    end

    def m_merchant_name
      SalesEngine::Database.each do |record| 
        puts record.m_merchant_name
      end
    end

    def self.random
      # puts "Printing random merchant!"
      return SalesEngine::Database.instance.merchants_data.sample
    end

    def self.find_by_merchant_name(parameter)
      @results = /^"#{parameter}"$/i
      SalesEngine::Database.instance.merchants_data.find do |dataline|
        dataline.m_merchant_name == @results
      end
      # return @results
    end

  end
end