module SalesEngine
  class InvoiceItems

  CSV_OPTIONS = {:headers => true, :header_converters => :symbol}

    def ii_invoice_items_id
      @loaded_data.each do |record| 
        puts record.ii_invoice_items_id
      end
    end

  end
end

  # invoice_items = Invoice_items.new("data/invoice_items.csv")
  # invoice_items.ii_invoice_items_id