require 'spec_helper' 

describe SalesEngine::Merchant do
  let(:merchant) { Fabricate(:merchant) }
  
  describe ".random" do
    context "when random method called" do
      it "returns a SalesEngine::Merchant" do
        merchant.class.should == SalesEngine::Merchant.new.class
      end
    end
  end

  describe ".find_by_X" do
    before(:each) do
      SalesEngine::Merchant.clear_merchants
      SalesEngine::Merchant.add_merchant(Fabricate(:merchant, :name => 'Jeff', :id => "1"))
      SalesEngine::Merchant.add_merchant(Fabricate(:merchant, :name => 'Jeff', :id => "2"))
    end

    it "takes a only valid attributes" do
      [:id, :name, :created_at, :updated_at].each do |attribute|
        method = "find_by_#{attribute}".to_sym
        SalesEngine::Merchant.should respond_to(method)
      end
    end

    it "returns only a single merchant" do
      SalesEngine::Merchant.find_by_id("2").should be_instance_of(SalesEngine::Merchant)
    end

    it "returns a matching merchant" do
      SalesEngine::Merchant.find_by_id("2").id.should == "2"
    end

    it "has two elements" do
      SalesEngine::Merchant.find_all_by_name("Jeff").count.should == 2
    end

    it "returns instances of the SalesEngine::Merchant object" do
      SalesEngine::Merchant.find_all_by_name("Jeff").each do |merchant|
        merchant.should be_instance_of(SalesEngine::Merchant)
      end
    end

    it "returns SalesEngine::Merchant objects containing matching attributes" do
      SalesEngine::Merchant.find_all_by_name("Jeff").each do |merchant|
        merchant.name.should == "Jeff"
      end        
    end

    describe "when find_by_name method is called" do

      context "when case-variant parameters are passed" do 
        ["Johns Inc", "johns inc", "JOHNS INC"].each do |param|
          it "returns the results from a case-insensitive search" do
            SalesEngine::Merchant.find_by_name(param).should == SalesEngine::Merchant.find_by_name("Johns Inc")
          end
        end
      end

      context "when invalid parameters are passed" do
        ["Jan's Jalopies", "23", ":hippo", ""].each do |param|
          it "returns nil" do
            SalesEngine::Merchant.find_by_name(param).should == nil
          end
        end    
      end

    end
    
    describe "when find_by_id method is called" do
      context "when invalid parameters are passed" do
        ["Jan's Jalopies", "1234", ":hippo", ""].each do |param|
          it "returns nil" do
            SalesEngine::Merchant.find_by_id(param).should == nil
          end
        end    
      end
    end

  end

  describe ".find_all_by_" do
    
    it "takes a only valid attributes" do
      [:id, :name, :created_at, :updated_at].each do |attribute|
        method = "find_all_by_#{attribute}".to_sym
        SalesEngine::Merchant.should respond_to(method)
      end
    end

    context "when search two results are found" do
      before(:each) do
        SalesEngine::Merchant.clear_merchants
        SalesEngine::Merchant.add_merchant(Fabricate(:merchant, :name => 'Jeff', :id => 1))
        SalesEngine::Merchant.add_merchant(Fabricate(:merchant, :name => 'Jeff', :id => 2))
      end

      it "has two elements" do
        SalesEngine::Merchant.find_all_by_name("Jeff").count.should == 2
      end

      it "returns instances of the SalesEngine::Merchant object" do
        SalesEngine::Merchant.find_all_by_name("Jeff").each do |merchant|
          merchant.should be_instance_of(SalesEngine::Merchant)
        end
      end

      it "returns SalesEngine::Merchant objects containing matching attributes" do
        SalesEngine::Merchant.find_all_by_name("Jeff").each do |merchant|
          merchant.name.should == "Jeff"
        end        
      end

    end


    context "when no search results are found" do
      before(:each) do
        SalesEngine::Merchant.clear_merchants
        SalesEngine::Merchant.add_merchant(Fabricate(:merchant, :name => 'Jeff', :id => 1))
      end

      it "returns the empty array" do
        SalesEngine::Merchant.find_all_by_name("Jan").should be_empty
      end
    end
  end 

  describe "#items" do

    let(:merchant) { Fabricate(:merchant_with_items) }

    it "does not return nil" do
      merchant.items.should_not == nil
    end

    it "does not return the empty array" do
      merchant.items.should_not == []
    end

    it "returns a collection of SalesEngine::Item instances" do
      merchant.items.each do |item|
        item.should be_a(SalesEngine::Item)
      end
    end

    it "returns Item instances whose Merchant ids correspond to the Merchant searched" do
      merchant.items.sample.send(:merchant_id) == merchant.id
    end
  end

  describe "#invoices" do

    let(:merchant) { Fabricate(:merchant_with_items_and_invoices) }

    it "does not return nil" do
      merchant.invoices.should_not == nil
    end

    it "does not return the empty array" do
      merchant.invoices.should_not be_empty
    end

    it "returns a collection of SalesEngine::Item instances" do
      merchant.invoices.each do |invoice|
        invoice.should be_a(SalesEngine::Invoice)
      end
    end

    it "returns Invoice instances whose Merchant ids correspond to the Merchant searched" do
      merchant.invoices.each do |invoice|
        invoice.merchant_id.should == merchant.id
      end
    end
  end

end