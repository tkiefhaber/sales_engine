Fabricator(:transaction, :class_name => "SalesEngine::Transaction") do
  id { sequence.to_s }
  invoice_id { sequence.to_s }
  result "success"
end

Fabricator(:bad_transaction, :from => :transaction) do
  result "failure"
end

Fabricator(:transaction_with_invoice, :from => :transaction) do
  invoice do |transaction| 
    Fabricate(:invoice, :transaction => transaction)
  end
end