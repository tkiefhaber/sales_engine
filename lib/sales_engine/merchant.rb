$LOAD_PATH << './'
require 'database'
require 'merchant_object'


class Merchant



  def m_merchant_name
    Database.each do |record| 
      puts record.m_merchant_name
    end
  end

end
