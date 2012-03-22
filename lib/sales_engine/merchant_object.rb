class MerchantObject

  attr_accessor :m_merchant_id, :m_merchant_name, :m_merchant_created, :m_merchant_updated

  def initialize(attributes = {})
    self.m_merchant_id        = attributes[:id]
    self.m_merchant_name      = attributes[:name]
    self.m_merchant_created   = attributes[:created_at]
    self.m_merchant_updated   = attributes[:updated_at]
  end
end