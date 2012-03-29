require 'sales_engine/database'

module SalesEngine
  module FindBy

    def define_finders_for(*attributes)
      attributes.each do |attribute|
        define_finder_for(attribute)
        define_all_finder_for(attribute)        
      end
    end

    def define_finder_for(attribute)
      define_method "find_by_#{attribute}" do |parameter|
        @input = parameter.downcase
        SalesEngine::Database.instance.merchants_data.find do |dataline|
          dataline.send(attribute.to_s).downcase == @input
        end
      end
    end

    def define_all_finder_for(attribute)
      define_method "find_all_by_#{attribute}" do |parameter|
        @input = parameter.downcase
        SalesEngine::Database.instance.merchants_data.select do |dataline|
          dataline.send(attribute.to_s).downcase == @input
        end
      end 
    end

  end
end