require 'date'

Fabricator(:invoice, :class_name => "SalesEngine::Invoice") do
  id { sequence.to_s }
  merchant_id { sequence.to_s }
  customer_id { sequence.to_s }
  created_at { Time.now }
  updated_at { Time.now }
  status "shipped" 
end

Fabricator(:invoice_with_transactions, :from => :invoice) do
  transactions do |invoice| 
    [Fabricate(:transaction, :invoice => invoice), Fabricate(:transaction, :invoice => invoice)]
  end
end

Fabricator(:invoice_with_bad_transactions, :from => :invoice) do
  transactions do |invoice| 
    [Fabricate(:bad_transaction, :invoice => invoice), Fabricate(:bad_transaction, :invoice => invoice)]
  end
end

Fabricator(:invoice_with_varying_transactions, :from => :invoice) do
  transactions do |invoice| 
    [Fabricate(:bad_transaction, :invoice => invoice), Fabricate(:bad_transaction, :invoice => invoice), Fabricate(:transaction, :invoice => invoice)]
  end
end

Fabricator(:invoice_with_invoice_items, :from => :invoice) do
  invoice_items do |invoice| 
    [Fabricate(:invoice_item, :invoice => invoice), Fabricate(:invoice_item, :invoice => invoice)]
  end
end

Fabricator(:invoice_with_items, :from => :invoice) do
  items do |invoice|
    [Fabricate(:item, :invoice => invoice), Fabricate(:item, :invoice => invoice)]
  end
end

Fabricator(:invoice_with_customers, :from => :invoice) do
  customer do |invoice|
    [Fabricate(:customer, :invoice => invoice), Fabricate(:customer, :invoice => invoice)]
  end
end