Fabricator(:invoice_item, :class_name => "SalesEngine::InvoiceItem") do
  id { sequence }
  merchant_id { sequence }
  customer_id { sequence }
  item_id { sequence }
end