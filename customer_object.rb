class Customer_Object

  attr_accessor :customer_id, :customer_fname, :customer_lname, :customer_created, :customer_updated

  def initialize(attributes = {})
    self.customer_id        = attributes[:id]
    self.customer_fname     = attributes[:first_name]
    self.customer_lname     = attributes[:last_name]
    self.customer_created   = attributes[:created_at]
    self.customer_updated   = attributes[:updated_at]
  end
end