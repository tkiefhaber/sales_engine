require 'spec_helper' 

describe SalesEngine::Transaction do
  
  describe "#invoice" do
    it "does not return nil" do
      SalesEngine::Transaction.invoice.should_not == nil
    end

    it "does not return the empty array" do
      SalesEngine::Transaction.invoice.should_not == []
    end

    it "returns a collection of SalesEngine::Item instances" do
      SalesEngine::Transaction.invoice.sample.class.should == SalesEngine::Invoice.new.class
    end

    it "returns Invoice instances whose InvoiceItem ids correspond to the InvoiceItem searched" do
      example_merchant = SalesEngine::Transaction
      example_merchant.invoice.sample.send(:invoice_id) == example_merchant.invoice_id
    end
  end

end