require 'date'

Fabricator(:merchant, :class_name => "SalesEngine::Merchant") do
  id { (1..100).to_a.sample }
  name { Faker::Name.name }
  created_at { Time.now }
  updated_at { Time.now }  
end

Fabricator(:merchant_with_items, :from => :merchant) do
  items { |merchant| [Fabricate(:item, :merchant => merchant), Fabricate(:item, :merchant => merchant)] }
end

Fabricator(:merchant_with_items_and_invoices, :from => :merchant_with_items) do
  invoices do |merchant| 
    [Fabricate(:invoice, :merchant => merchant), Fabricate(:invoice, :merchant => merchant)]
  end
end

Fabricator(:merchant_with_invoices, :from => :merchant) do
  invoices do |merchant| 
    [Fabricate(:invoice, :merchant => merchant)]
  end
end

Fabricator(:merchant_with_invoices_and_invoice_items, :from => :merchant_with_invoices) do
  invoice_items do |merchant| 
    [Fabricate(:invoice_items, :merchant => merchant)]
  end
end
