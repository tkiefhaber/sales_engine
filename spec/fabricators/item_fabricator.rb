Fabricator(:item, :class_name => "SalesEngine::Item") do
  id { sequence }
  name { Faker::Lorem.words(1).join }
end