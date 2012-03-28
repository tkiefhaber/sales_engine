require 'spec_helper' 

describe SalesEngine::Transaction do
  describe "#successful?" do
    let(:transaction) { Fabricate(:transaction) }
    let(:bad_transaction) { Fabricate(:bad_transaction) }

    context "when the transaction is successful" do
      it "is true" do
        transaction.should be_successful
      end
    end

    context "when the transaction has not succeeded" do
      it "is false" do
        bad_transaction.should_not be_successful
      end
    end
  end

  describe "#invoice" do

    context "when a transaction has an invoice" do

    let(:transaction) { Fabricate(:transaction_with_invoice) }

      it "does not return nil" do
        transaction.invoice.should_not == nil
      end

      it "returns a collection of SalesEngine::Item instances" do
        transaction.invoice.should be_a(SalesEngine::Invoice)
      end

      it "returns Invoice instances whose Id correspond to the Invoice_Id of the Transaction searched" do
        transaction.invoice.id == transaction.invoice_id
      end
    end

    context "when a transaction does not have an invoice" do

      let(:transaction) { Fabricate(:transaction) }
      
      it "it returns nil" do
        transaction.invoice.should == nil
      end
    end
  end
end