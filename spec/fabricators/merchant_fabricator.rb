require 'date'

Fabricator(:merchant, :class_name => "SalesEngine::Merchant") do
  id { (1..100).to_a.sample }
  name { Faker::Name.name }
  created_at { Time.now }
  updated_at { Time.now }
  items { [Fabricate(:item), Fabricate(:item)] }
  invoices { [Fabricate(:invoice), Fabricate(:invoice)] }
end

