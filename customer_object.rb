class CustomerObject

  attr_accessor :c_customer_id, :c_customer_fname, :c_customer_lname, :c_customer_created, :c_customer_updated

  def initialize(attributes = {})
    self.c_customer_id        = attributes[:id]
    self.c_customer_fname     = attributes[:first_name]
    self.c_customer_lname     = attributes[:last_name]
    self.c_customer_created   = attributes[:created_at]
    self.c_customer_updated   = attributes[:updated_at]
  end
end