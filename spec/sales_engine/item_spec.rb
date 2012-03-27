require 'spec_helper' 

describe SalesEngine::Item do
  describe ".random" do
    context "when random method called" do
      it "returns a SalesEngine::Item" do
        SalesEngine::Item.random.class.should == SalesEngine::Item.new.class
      end
    end
  end

  describe ".find_by_" do

    it "takes a only valid attributes" do
      [:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at].each do |attribute|
        method = "find_by_#{attribute}".to_sym
        SalesEngine::Item.should respond_to(method)
      end
    end

    it "returns only a single instance" do
      SalesEngine::Item.find_by_created_at("2012-02-26 20:56:50 UTC").instance_of?(SalesEngine::Item).should == true
      SalesEngine::Item.find_by_updated_at("2012-02-26 20:56:50 UTC").instance_of?(SalesEngine::Item).should == true
      SalesEngine::Item.find_by_name("Item Ea Quis").instance_of?(SalesEngine::Item).should == true
      SalesEngine::Item.find_by_description("Accusamus commodi molestias sint et sit. Iste et sit. Ut in aut.").instance_of?(SalesEngine::Item).should == true
      SalesEngine::Item.find_by_id("26").instance_of?(SalesEngine::Item).should == true
      SalesEngine::Item.find_by_merchant_id("26").instance_of?(SalesEngine::Item).should == true
      SalesEngine::Item.find_by_unit_price("7661").instance_of?(SalesEngine::Item).should == true
    end

    it "returns an instance of the SalesEngine::Item object" do
      SalesEngine::Item.find_by_created_at("2012-02-26 20:56:50 UTC").class.should == SalesEngine::Item.new.class
      SalesEngine::Item.find_by_updated_at("2012-02-26 20:56:50 UTC").class.should == SalesEngine::Item.new.class
      SalesEngine::Item.find_by_name("Item Ea Quis").class.should == SalesEngine::Item.new.class
      SalesEngine::Item.find_by_description("Accusamus commodi molestias sint et sit. Iste et sit. Ut in aut.").class.should == SalesEngine::Item.new.class
      SalesEngine::Item.find_by_id("26").class.should == SalesEngine::Item.new.class
      SalesEngine::Item.find_by_merchant_id("26").class.should == SalesEngine::Item.new.class
      SalesEngine::Item.find_by_unit_price("7661").class.should == SalesEngine::Item.new.class
    end

    it "returns an instance containing a matching attribute" do
      SalesEngine::Item.find_by_created_at("2012-02-26 20:56:50 UTC").respond_to?(:created_at).should == true
      SalesEngine::Item.find_by_updated_at("2012-02-26 20:56:50 UTC").respond_to?(:updated_at).should == true
      SalesEngine::Item.find_by_name("Item Ea Quis").respond_to?(:created_at).should == true
      SalesEngine::Item.find_by_description("Accusamus commodi molestias sint et sit. Iste et sit. Ut in aut.").respond_to?(:created_at).should == true
      SalesEngine::Item.find_by_id("26").respond_to?(:created_at).should == true
      SalesEngine::Item.find_by_merchant_id("26").respond_to?(:created_at).should == true
      SalesEngine::Item.find_by_unit_price("7661").respond_to?(:created_at).should == true
    end

    describe "when find_by_name method is called" do

      context "when case-variant parameters are passed" do 
        ["Item Ea Quis", "Item EA QUIS", "item ea quis"].each do |param|
          it "returns the results from a case-insensitive search" do
            SalesEngine::Item.find_by_name(param).should == SalesEngine::Item.find_by_name("Item Ea Quis")
          end
        end
      end

      context "when invalid parameters are passed" do
        ["Jan's Jalopies", "23", ":hippo", ""].each do |param|
          it "returns nil" do
            SalesEngine::Item.find_by_name(param).should == nil
          end
        end    
      end

    end

    describe "when find_by_description method is called" do

      context "when case-variant parameters are passed" do 
        ["Accusamus commodi molestias sint et sit. Iste et sit. Ut in aut.", 
          "ACCUSAMUS COMMODI MOLESTIAS SINT ET SIT. ISTE ET SIT. UT IN AUT.", 
          "accusamus commodi molestias sint et sit. iste et sit. ut in aut."].each do |param|
          it "returns the results from a case-insensitive search" do
            SalesEngine::Item.find_by_description(param).should == 
              SalesEngine::Item.find_by_description("Accusamus commodi molestias sint et sit. Iste et sit. Ut in aut.")
          end
        end
      end

      context "when invalid parameters are passed" do
        ["Jan's Jalopies", "23", ":hippo", ""].each do |param|
          it "returns nil" do
            SalesEngine::Item.find_by_description(param).should == nil
          end
        end    
      end

    end
    
    describe "when find_by_id method is called" do
      context "when invalid parameters are passed" do
        ["Jan's Jalopies", "1234018291", ":hippo", ""].each do |param|
          it "returns nil" do
            SalesEngine::Item.find_by_id(param).should == nil
          end
        end    
      end
    end

    describe "when find_by_unit_price method is called" do
      context "when invalid parameters are passed" do
        ["Jan's Jalopies", "00120184012", ":hippo", ""].each do |param|
          it "returns nil" do
            SalesEngine::Item.find_by_unit_price(param).should == nil
          end
        end    
      end
    end

    describe "when find_by_merchant_id method is called" do
      context "when invalid parameters are passed" do
        ["Jan's Jalopies", "1234", ":hippo", ""].each do |param|
          it "returns an empty array" do
            SalesEngine::Item.find_by_merchant_id(param).should == nil
          end
        end    
      end
    end

  end

  describe ".find_all_by_" do
    
    it "takes a only valid attributes" do
      [:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at].each do |attribute|
        method = "find_all_by_#{attribute}".to_sym
        SalesEngine::Item.should respond_to(method)
      end
    end

    context "when search results are found" do
      it "returns an array of data" do
        SalesEngine::Item.find_all_by_created_at("2012-02-26 20:56:50 UTC").class.should == Array
        SalesEngine::Item.find_all_by_updated_at("2012-02-26 20:56:50 UTC").class.should == Array
        SalesEngine::Item.find_all_by_name("Item Ea Quis").class.should == Array
        SalesEngine::Item.find_all_by_description("Accusamus commodi molestias sint et sit. Iste et sit. Ut in aut.").class.should == Array
        SalesEngine::Item.find_all_by_id("26").class.should == Array
        SalesEngine::Item.find_all_by_merchant_id("26").class.should == Array
        SalesEngine::Item.find_all_by_unit_price("7661").class.should == Array
      end

      it "returns instances of the SalesEngine::Item object" do
        SalesEngine::Item.find_all_by_created_at("2012-02-26 20:56:50 UTC").sample.class.should == SalesEngine::Item.new.class
        SalesEngine::Item.find_all_by_updated_at("2012-02-26 20:56:50 UTC").sample.class.should == SalesEngine::Item.new.class
        SalesEngine::Item.find_all_by_name("Item Ea Quis").sample.class.should == SalesEngine::Item.new.class
        SalesEngine::Item.find_all_by_description("Accusamus commodi molestias sint et sit. Iste et sit. Ut in aut.").sample.class.should == SalesEngine::Item.new.class
        SalesEngine::Item.find_all_by_id("26").sample.class.should == SalesEngine::Item.new.class
        SalesEngine::Item.find_all_by_merchant_id("26").sample.class.should == SalesEngine::Item.new.class
        SalesEngine::Item.find_all_by_unit_price("7661").sample.class.should == SalesEngine::Item.new.class
      end

      it "returns SalesEngine::Item objects containing matching attributes" do
        SalesEngine::Item.find_all_by_created_at("2012-02-26 20:56:50 UTC").sample.respond_to?(:created_at).should == true
        SalesEngine::Item.find_all_by_updated_at("2012-02-26 20:56:50 UTC").sample.respond_to?(:updated_at).should == true
        SalesEngine::Item.find_all_by_name("Item Ea Quis").sample.respond_to?(:name).should == true
        SalesEngine::Item.find_all_by_description("Accusamus commodi molestias sint et sit. Iste et sit. Ut in aut.").sample.respond_to?(:description).should == true
        SalesEngine::Item.find_all_by_id("26").sample.respond_to?(:id).should == true
        SalesEngine::Item.find_all_by_merchant_id("26").sample.respond_to?(:merchant_id).should == true
        SalesEngine::Item.find_all_by_unit_price("7661").sample.respond_to?(:unit_price).should == true
      end
      
    end

    context "when no search results are found" do

      it "returns the empty array" do
        SalesEngine::Item.find_all_by_created_at("2012-02-26 20:56:50").should == []
        SalesEngine::Item.find_all_by_updated_at("2012-02-26 UTC").should == []
        SalesEngine::Item.find_all_by_name("FUnn SalesEngine::ItemZ").should == []
        SalesEngine::Item.find_all_by_description("happy lil' description").should == []
        SalesEngine::Item.find_all_by_id("123465789642").should == []
        SalesEngine::Item.find_all_by_merchant_id("123809531").should == []
        SalesEngine::Item.find_all_by_unit_price("901308321").should == []
      end

    end
  end

  describe "#invoice_items" do
    let(:item) { Fabricate(:item) }

    it "does not return nil" do
      item.invoice_items.should_not == nil
    end

    it "does not return the empty array" do
      item.invoice_items.should_not == []
    end

    it "returns a collection of SalesEngine::Item instances" do
      item.invoice_items.sample.should be_a (SalesEngine::InvoiceItem)
    end

    it "returns InvoiceItem instances whose Item ids correspond to the Merchant searched" do
      item.invoice_items.sample.send(:item_id) == item.id
    end
  end

  describe "#merchant" do

    let(:item) { Fabricate(:item) }

    it "does not return nil" do
      item.merchant.should_not == nil
    end

    it "does not return the empty array" do
      item.merchant.should_not == []
    end

    it "returns a collection of SalesEngine::Item instances" do
      item.merchant.should be_a( SalesEngine::Merchant )
    end

    it "returns Merchant instances whose Merchant ID corresponds to that of the Item searched" do
      item.merchant.id.should == item.merchant_id
    end
  end

end