Fabricator(:customer, :class_name => "SalesEngine::Customer") do
  id { sequence.to_s }
  first_name { Faker::Name.name }
  last_name { Faker::Name.name }
  #invoices { [Fabricate(:invoice), Fabricate(:invoice)] }
end