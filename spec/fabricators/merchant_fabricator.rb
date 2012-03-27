require 'date'

Fabricator(:merchant, :class_name => "SalesEngine::Merchant") do
  id { (1..100).to_a.sample }
  name { Faker::Name.name }
  created_at { Time.now }
  updated_at { Time.now }
  items { |merchant| [Fabricate(:item, :merchant => merchant), Fabricate(:item, :merchant => merchant)] }
  invoices { |merchant| [Fabricate(:invoice, :merchant => merchant), Fabricate(:invoice, :merchant => merchant)] }
end

