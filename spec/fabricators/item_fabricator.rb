Fabricator(:item, :class_name => "SalesEngine::Item") do
  id { sequence }
  name { Faker::Lorem.words(1).join }
  merchant_id { sequence }
  merchant { |item| [Fabricate(:merchant, :item => item)] }
  invoice_item { |item| [Fabricate(:invoice_item, :item => item), Fabricate(:invoice_item, :item => item)] }
end