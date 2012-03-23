module SalesEngine
  class Item

    def it_item_name
      Database.each do |record| 
        puts record.it_item_name
      end
    end

  end
end