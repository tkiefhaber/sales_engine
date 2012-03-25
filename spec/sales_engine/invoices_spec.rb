require 'spec_helper' 

describe SalesEngine::Invoice do
  describe ".random" do
    context "when random method called" do
      it "returns a SalesEngine::Invoice" do
        SalesEngine::Invoice.random.class.should == SalesEngine::Invoice.new.class
      end
    end
  end

  describe ".find_by_" do

    it "takes a only valid attributes" do
      [:id, :customer_id, :merchant_id, :status, :created_at, :updated_at].each do |attribute|
        method = "find_by_#{attribute}".to_sym
        SalesEngine::Invoice.should respond_to(method)
      end
    end

    it "returns only a single instance" do
      SalesEngine::Invoice.find_by_created_at("2012-02-26 07:56:58 UTC").instance_of?(SalesEngine::Invoice).should == true
      SalesEngine::Invoice.find_by_updated_at("2012-02-26 20:56:56 UTC").instance_of?(SalesEngine::Invoice).should == true
      SalesEngine::Invoice.find_by_customer_id("6").instance_of?(SalesEngine::Invoice).should == true
      SalesEngine::Invoice.find_by_merchant_id("94").instance_of?(SalesEngine::Invoice).should == true
      SalesEngine::Invoice.find_by_id("26").instance_of?(SalesEngine::Invoice).should == true
      SalesEngine::Invoice.find_by_status("shipped").instance_of?(SalesEngine::Invoice).should == true
    end

    it "returns an instance of the SalesEngine::Invoice object" do
      SalesEngine::Invoice.find_by_created_at("2012-02-26 07:56:58 UTC").class.should == SalesEngine::Invoice.new.class
      SalesEngine::Invoice.find_by_updated_at("2012-02-26 20:56:56 UTC").class.should == SalesEngine::Invoice.new.class
      SalesEngine::Invoice.find_by_customer_id("6").class.should == SalesEngine::Invoice.new.class
      SalesEngine::Invoice.find_by_merchant_id("94").class.should == SalesEngine::Invoice.new.class
      SalesEngine::Invoice.find_by_id("26").class.should == SalesEngine::Invoice.new.class
      SalesEngine::Invoice.find_by_status("shipped").class.should == SalesEngine::Invoice.new.class
    end

    it "returns an instance containing a matching attribute" do
      SalesEngine::Invoice.find_by_created_at("2012-02-26 07:56:58 UTC").respond_to?(:created_at).should == true
      SalesEngine::Invoice.find_by_updated_at("2012-02-26 20:56:56 UTC").respond_to?(:updated_at).should == true
      SalesEngine::Invoice.find_by_customer_id("6").respond_to?(:customer_id).should == true
      SalesEngine::Invoice.find_by_merchant_id("94").respond_to?(:merchant_id).should == true
      SalesEngine::Invoice.find_by_id("26").respond_to?(:id).should == true
      SalesEngine::Invoice.find_by_status("shipped").respond_to?(:status).should == true
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
        ["Jan's Jalopies", "12340812918", ":hippo", ""].each do |param|
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

    context "when search results are found" do
      it "returns an array of data" do
        SalesEngine::Invoice.find_all_by_created_at("2012-02-26 07:56:58 UTC").class.should == Array
        SalesEngine::Invoice.find_all_by_updated_at("2012-02-26 20:56:56 UTC").class.should == Array
        SalesEngine::Invoice.find_all_by_customer_id("6").class.should == Array
        SalesEngine::Invoice.find_all_by_merchant_id("94").class.should == Array
        SalesEngine::Invoice.find_all_by_id("26").class.should == Array
        SalesEngine::Invoice.find_all_by_status("shipped").class.should == Array
      end

      it "returns instances of the SalesEngine::Invoice object" do
        SalesEngine::Invoice.find_all_by_created_at("2012-02-26 07:56:58 UTC").sample.class.should == SalesEngine::Invoice.new.class
        SalesEngine::Invoice.find_all_by_updated_at("2012-02-26 20:56:56 UTC").sample.class.should == SalesEngine::Invoice.new.class
        SalesEngine::Invoice.find_all_by_customer_id("6").sample.class.should == SalesEngine::Invoice.new.class
        SalesEngine::Invoice.find_all_by_merchant_id("94").sample.class.should == SalesEngine::Invoice.new.class
        SalesEngine::Invoice.find_all_by_id("26").sample.class.should == SalesEngine::Invoice.new.class
        SalesEngine::Invoice.find_all_by_status("shipped").sample.class.should == SalesEngine::Invoice.new.class
      end

      it "returns SalesEngine::Invoice objects containing matching attributes" do
        SalesEngine::Invoice.find_all_by_created_at("2012-02-26 07:56:58 UTC").sample.respond_to?(:created_at).should == true
        SalesEngine::Invoice.find_all_by_updated_at("2012-02-26 20:56:56 UTC").sample.respond_to?(:updated_at).should == true
        SalesEngine::Invoice.find_all_by_customer_id("6").sample.respond_to?(:customer_id).should == true
        SalesEngine::Invoice.find_all_by_merchant_id("94").sample.respond_to?(:merchant_id).should == true
        SalesEngine::Invoice.find_all_by_id("26").sample.respond_to?(:id).should == true
        SalesEngine::Invoice.find_all_by_status("shipped").sample.respond_to?(:status).should == true
      end
    end

    context "when no search results are found" do

      it "returns the empty array" do
        SalesEngine::Invoice.find_all_by_created_at("2012-02-26 07:56:58").should == []
        SalesEngine::Invoice.find_all_by_updated_at("2012-02-26 UTC").should == []
        SalesEngine::Invoice.find_all_by_customer_id("6666").should == []
        SalesEngine::Invoice.find_all_by_merchant_id("94506652").should == []
        SalesEngine::Invoice.find_all_by_id("900917291").should == []
        SalesEngine::Invoice.find_all_by_status("unshipped").should == []
      end
    end

  end 
end