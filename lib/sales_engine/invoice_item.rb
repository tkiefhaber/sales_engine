module SalesEngine
  
  class InvoiceItem

    attr_accessor :id, :item_id, :invoice_id, 
                  :quantity, :unit_price, 
                  :created_at, :updated_at

    def initialize(attributes = {})
      self.id               = attributes[:id].to_i
      self.item_id          = attributes[:item_id].to_i
      self.invoice_id       = attributes[:invoice_id].to_i
      self.quantity         = attributes[:quantity].to_i
      self.unit_price       = BigDecimal.new(attributes[:unit_price].to_s)/100
      self.created_at       = Date.parse(attributes[:created_at].to_s)
      self.updated_at       = Date.parse(attributes[:updated_at].to_s)
    end

    def self.random
      return SalesEngine::Database.instance.invoice_items_data.sample
    end

    class << self
      [:id, :item_id, :invoice_id, :quantity, 
        :unit_price, :created_at, :updated_at].each do |attribute|
        define_method "find_by_#{attribute}" do |parameter|
          SalesEngine::Database.instance.invoice_items_data.select do |inv_item|
            return inv_item if inv_item.send(attribute) == parameter
          end
        end

        define_method "find_all_by_#{attribute}" do |parameter|
          SalesEngine::Database.instance.invoice_items_data.select do |inv_item|
            inv_item.send(attribute) == parameter
          end
        end 
      end
    end
  
    def invoice=(input)
      @invoice = input
    end

    def item=(input)
      @item = input
    end

    def total
      @total ||= quantity * unit_price
    end

    def invoice
      i = SalesEngine::Database.instance.invoices_data
      @invoice ||= i.find do |invoice|
        if invoice.id == self.invoice_id
          invoice
        end
      end
    end

    def item
      @item ||= SalesEngine::Database.instance.items_data.find do |item|
        if item.id == self.item_id
          item
        end
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
    
    def invoice_successful?
      self.invoice.paid?
    end

  end
end