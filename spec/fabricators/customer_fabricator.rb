Fabricator(:customer, :class_name => "SalesEngine::Customer") do
  id { sequence }
  invoices { [Fabricate(:invoice), Fabricate(:invoice)] }
end