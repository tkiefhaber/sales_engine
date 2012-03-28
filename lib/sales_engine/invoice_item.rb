module SalesEngine
  
  class InvoiceItem

    attr_accessor :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

    def initialize(attributes = {})
      self.id                  = attributes[:id]
      self.item_id             = attributes[:item_id]
      self.invoice_id          = attributes[:invoice_id]
      self.quantity            = attributes[:quantity].to_i
      self.unit_price          = attributes[:unit_price].to_i
      self.created_at          = Date.parse(attributes[:created_at])
      self.updated_at          = Date.parse(attributes[:updated_at])
    end
  
    def invoice=(input)
      # self.merchant_id = input.id
      @invoice = input
    end

    def item=(input)
      # self.merchant_id = input.id
      @item = input
    end

    def invoice
      puts "This is the invoice id: #{self.invoice_id}"
      # returns the items for a given instance of merchant
      @invoice || SalesEngine::Database.instance.invoices_data.find do |invoice_object|
        self.invoice_id == invoice_object.send(:id)
      end
    end

    def item
      puts "This is the item id: #{self.item_id}"
      # returns the items for a given instance of merchant
      @item || SalesEngine::Database.instance.items_data.find do |item_object|
        self.item_id == item_object.send(:id)
      end
    end
  end
end