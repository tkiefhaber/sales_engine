module SalesEngine

  class Transactions


    def t_transactions_id
      Database.each do |record| 
        puts record.t_transactions_id
      end
    end

  end

end
