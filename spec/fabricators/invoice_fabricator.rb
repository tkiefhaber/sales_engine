Fabricator(:invoice, :class_name => "SalesEngine::Invoice") do
  id { sequence }
  merchant_id { sequence }
  customer_id { sequence }
end