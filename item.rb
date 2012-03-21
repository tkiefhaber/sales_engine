$LOAD_PATH << './'
require 'database'
require 'item_object'

class Item

  def it_item_name
    Database.each do |record| 
      puts record.it_item_name
    end
  end

end
