require 'spec_helper' 

describe SalesEngine::Invoice do
  describe "#paid?" do    
  let(:invoice_with_transactions) { Fabricate(:invoice_with_transactions) }
  let(:invoice_with_varying_transactions) { Fabricate(:invoice_with_varying_transactions) }
  let(:invoice_with_bad_transactions) { Fabricate(:invoice_with_bad_transactions) }

    context "when there is a successful transaction" do
      it "is true" do
        invoice_with_transactions.should be_paid
      end
    end

    context "when there are multiple bad transactions and one good transaction" do
      it "is true" do
        invoice_with_varying_transactions.should be_paid
      end
    end

    context "when there is no successful transaction" do
      it "is false" do
        invoice_with_bad_transactions.should_not be_paid
      end
    end

  end

  describe ".random" do
    let(:invoice) { Fabricate(:invoice) }
    context "when random method called" do
      it "returns a SalesEngine::Invoice" do
        invoice.class.should == SalesEngine::Invoice.new.class
      end
    end
  end

  describe ".find_by_x" do
    before(:each) do
      SalesEngine::Invoice.clear_invoices
      SalesEngine::Invoice.add_invoice(Fabricate(:invoice, :id => "2"))
      SalesEngine::Invoice.add_invoice(Fabricate(:invoice))
    end 


    it "takes a only valid attributes" do
      [:id, :customer_id, :merchant_id, :status, :created_at, :updated_at].each do |attribute|
        method = "find_by_#{attribute}".to_sym
        SalesEngine::Invoice.should respond_to(method)
      end
    end

    it "returns only a single instance" do
      SalesEngine::Invoice.find_by_id("2").should be_instance_of(SalesEngine::Invoice)
    end

    it "returns a matching invoice" do
      SalesEngine::Invoice.find_by_id("2").id.should == "2"
    end


    describe "when find_by_status method is called" do

      context "when case-variant parameters are passed" do 
        ["Shipped", "SHIPPED", "shipped"].each do |param|
          it "returns the results from a case-insensitive search" do
            SalesEngine::Invoice.find_by_status(param).should == SalesEngine::Invoice.find_by_status("shipped")
          end
        end
      end

      context "when invalid parameters are passed" do
        ["Jan's Jalopies", "23", ":hippo", ""].each do |param|
          it "returns nil" do
            SalesEngine::Invoice.find_by_status(param).should == nil
          end
        end    
      end
    end
    
    describe "when find_by_id method is called" do
      context "when invalid parameters are passed" do
        ["Jan's Jalopies", "1234", ":hippo", ""].each do |param|
          it "returns nil" do
            SalesEngine::Invoice.find_by_id(param).should == nil
          end
        end    
      end
    end

    describe "when find_by_customer_id method is called" do
      context "when invalid parameters are passed" do
        ["Jan's Jalopies", "1234", ":hippo", ""].each do |param|
          it "returns nil" do
            SalesEngine::Invoice.find_by_customer_id(param).should == nil
          end
        end    
      end
    end

    describe "when find_by_merchant_id method is called" do
      context "when invalid parameters are passed" do
        ["Jan's Jalopies", "1234", ":hippo", ""].each do |param|
          it "returns nil" do
            SalesEngine::Invoice.find_by_merchant_id(param).should == nil
          end
        end    
      end
    end

  end

  describe ".find_all_by_" do
    
    it "takes a only valid attributes" do
      [:id, :customer_id, :merchant_id, :status, :created_at, :updated_at].each do |attribute|
        method = "find_all_by_#{attribute}".to_sym
        SalesEngine::Invoice.should respond_to(method)
      end
    end

    context "when two search results are found" do
      before(:each) do
        SalesEngine::Invoice.clear_invoices
        SalesEngine::Invoice.add_invoice(Fabricate(:invoice, :merchant_id => 'Jeff', :id => 1))
        SalesEngine::Invoice.add_invoice(Fabricate(:invoice, :merchant_id => 'Jeff', :id => 2))
      end

      it "has two elements" do
        SalesEngine::Invoice.find_all_by_merchant_id("Jeff").count.should == 2
      end

      it "returns instances of the SalesEngine::Invoice object" do
        SalesEngine::Invoice.find_all_by_merchant_id("Jeff").each do |invoice|
          invoice.should be_instance_of(SalesEngine::Invoice)
        end
      end

      it "returns SalesEngine::Invoice objects containing matching attributes" do
        SalesEngine::Invoice.find_all_by_merchant_id("Jeff").each do |invoice|
          invoice.merchant_id.should == "Jeff"
        end        
      end
    end

    context "when no search results are found" do
      before(:each) do
        SalesEngine::Invoice.clear_invoices
        SalesEngine::Invoice.add_invoice(Fabricate(:invoice, :customer_id => 'Jeff', :id => 1))
      end

      it "returns the empty array" do
        SalesEngine::Invoice.find_all_by_customer_id("Jan").should be_empty
      end
    end

  end

  describe "#transactions" do

    let(:invoice) { Fabricate(:invoice_with_transactions) }

    it "does not return nil" do
      invoice.transactions.should_not == nil
    end

    it "does not return the empty array" do
      invoice.transactions.should_not == []
    end

    it "returns a collection of SalesEngine::Item instances" do
      invoice.transactions.each do |transaction|
        transaction.should be_a(SalesEngine::Transaction)
      end
    end

    it "returns Transaction instances whose Invoice id corresponds to the Invoice searched" do
      invoice.transactions.sample.invoice_id == invoice.id
    end
  end

  describe "#invoice_items" do

    let(:invoice) { Fabricate(:invoice_with_invoice_items) }

    it "does not return nil" do
      invoice.invoice_items.should_not == nil
    end

    it "does not return the empty array" do
      invoice.invoice_items.should_not == []
    end

    it "returns a collection of SalesEngine::Item instances" do
      invoice.invoice_items.each do |invoice_item|
        invoice_item.should be_a(SalesEngine::InvoiceItem)
      end
    end

    it "returns InvoiceItem instances whose Invoice ids correspond to the Invoice searched" do
      invoice.invoice_items.sample.invoice_id == invoice.id
    end
  end

  describe "#items" do

    let(:invoice) { Fabricate(:invoice_with_items) }

    it "does not return nil" do
      invoice.items.should_not == nil
    end

    it "does not return the empty array" do
      invoice.items.should_not be_empty
    end

    it "returns a collection of SalesEngine::Item instances" do
      invoice.items.each do |item|
        item.should be_a(SalesEngine::Item)
      end
    end

    it "returns Item instances whose Invoice ids correspond to the Invoice searched" do
      invoice.invoice_items.each do |invoice_item|
        invoice_item.item_id == invoice.items.sample.id
      end
    end
  end

  describe "#customer" do
    let(:invoice) { Fabricate(:invoice_with_customers) }

    it "does not return nil" do
      invoice.customer.should_not == nil
    end

    it "does not return the empty array" do
      invoice.customer.should_not == []
    end

    it "returns a collection of SalesEngine::Customer instances" do
      invoice.customer.each do |customer|
        customer.should be_a(SalesEngine::Customer)
      end
    end

    it "returns Customer instance whose Id corresponds to the Customer ID of the Invoice searched" do
      invoice.customer.each do |customer|
        customer.id == invoice.customer_id
      end
    end
  end
end