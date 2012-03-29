require 'spec_helper' 

describe SalesEngine::InvoiceItem do
  
  describe "#invoice" do
    it "does not return nil" do
      SalesEngine::InvoiceItem.invoice.should_not == nil
    end

    it "does not return the empty array" do
      SalesEngine::InvoiceItem.invoice.should_not == []
    end

    it "returns a collection of SalesEngine::Item instances" do
      SalesEngine::InvoiceItem.invoice.sample.class.should == SalesEngine::Invoice.new.class
    end

    it "returns Invoice instances whose InvoiceItem ids correspond to the InvoiceItem searched" do
      example_merchant = SalesEngine::InvoiceItem
      example_merchant.invoice.sample.send(:invoice_item_id) == example_merchant.invoice_item_id
    end
  end

  describe "#item" do
    it "does not return nil" do
      SalesEngine::InvoiceItem.item.should_not == nil
    end

    it "does not return the empty array" do
      SalesEngine::InvoiceItem.item.should_not == []
    end

    it "returns a collection of SalesEngine::Item instances" do
      SalesEngine::InvoiceItem.item.sample.class.should == SalesEngine::Item.new.class
    end

    it "returns Item instances whose InvoiceItem ids correspond to the InvoiceItem searched" do
      example_merchant = SalesEngine::InvoiceItem
      example_merchant.item.sample.send(:invoice_item_id) == example_merchant.invoice_item_id
    end
  end

end