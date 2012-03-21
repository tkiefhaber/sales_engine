$LOAD_PATH << './'
require 'database'
require 'Invoices_objects'


class Invoices

  def in_invoices_id
    Database.each do |record| 
      puts record.in_invoices_id
    end
  end

end

