$LOAD_PATH << './'
require 'database'
require 'customer_object'


class Customer

  def c_customer_name
    Database.each do |record| 
      puts record.c_customer_fname + " " + record.c_customer_lname
    end
  end

end
