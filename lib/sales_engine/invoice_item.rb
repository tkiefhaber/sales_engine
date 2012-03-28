module SalesEngine
  
  class InvoiceItem

    attr_accessor :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

    def initialize(attributes = {})
      self.id                  = attributes[:id]
      self.item_id             = attributes[:item_id]
      self.invoice_id          = attributes[:invoice_id]
      self.quantity            = attributes[:quantity].to_i
      self.unit_price          = BigDecimal.new(attributes[:unit_price])/100
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

    def total
      @total ||= quantity * unit_price
    end

    def invoice
      @invoice || SalesEngine::Database.instance.invoices_data.find do |invoice_object|
        self.invoice_id == invoice_object.send(:id)
      end
    end

    def item
      @item || SalesEngine::Database.instance.items_data.find do |item_object|
        self.item_id == item_object.send(:id)
      end
    end

    def self.create_invoice_items(invoice_id, items)
      items_hash = {}
      items.each do |item|
        items_hash[item.id] = [items.count(item), item.unit_price]
      end

      items_hash.each do |item_id, values|
        ii = InvoiceItem.new(:id          => find_new_invoice_item_id,
                             :item_id     => item_id, 
                             :invoice_id  => invoice_id,
                             :quantity    => values[0], 
                             :unit_price  => values[1],
                             :created_at  => Time.now.to_s,
                             :updated_at  => Time.now.to_s )
        SalesEngine::Database.instance.add_invoice_item(ii)
        ii
      end
    end

    def self.find_new_invoice_item_id
      SalesEngine::Database.instance.invoice_items_data.size.to_i + 1
    end


    # def self.create(attributes={})
    #   ii = InvoiceItem.new(:id             => attributes[:id], 
    #                   :item_id             => attributes[:item_id],
    #                   :invoice_id          => attributes[:invoice_id],
    #                   :quantity            => attributes[:quantity],
    #                   :unit_price          => attributes[:unit_price].to_i,
    #                   :created_at          => Time.now.to_s,
    #                   :updated_at          => Time.now.to_s)
    #   SalesEngine::Database.add_invoice_item(ii)
    # end

  end
end