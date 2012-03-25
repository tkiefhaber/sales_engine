class MerchantObject

  attr_accessor :id, :name, :created_at, :updated_at

  def initialize(attributes = {})
    self.id           = attributes[:id].to_s
    self.name         = attributes[:name]
    self.created_at   = attributes[:created_at]
    self.updated_at   = attributes[:updated_at]
  end

  def invoices
    # returns all invoice objects associated with this merchant
  end
end