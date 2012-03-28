Fabricator(:invoice_item, :class_name => "SalesEngine::InvoiceItem") do
  id { sequence }
  invoice_id { sequence }
end