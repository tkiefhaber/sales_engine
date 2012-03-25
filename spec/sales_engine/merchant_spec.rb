require 'spec_helper' 

describe SalesEngine::Merchant do
  describe ".random" do
    context "when random method called" do
      it "returns a MerchantObject" do
        SalesEngine::Merchant.random.class.should == MerchantObject.new.class
      end
    end
  end

  describe ".find_by_" do

    it "takes a only valid attributes" do
      [:id, :name, :created_at, :updated_at].each do |attribute|
        method = "find_by_#{attribute}".to_sym
        SalesEngine::Merchant.should respond_to(method)
      end
    end

    it "returns only a single instance" do
      SalesEngine::Merchant.find_by_created_at("2012-02-26 20:56:50 UTC").instance_of?(MerchantObject).should == true
      SalesEngine::Merchant.find_by_updated_at("2012-02-26 20:56:50 UTC").instance_of?(MerchantObject).should == true
      SalesEngine::Merchant.find_by_name("Johns Inc").instance_of?(MerchantObject).should == true
      SalesEngine::Merchant.find_by_id("2").instance_of?(MerchantObject).should == true
    end

    it "returns an instance of the Merchant object" do
      SalesEngine::Merchant.find_by_created_at("2012-02-26 20:56:50 UTC").class.should == MerchantObject.new.class
      SalesEngine::Merchant.find_by_updated_at("2012-02-26 20:56:50 UTC").class.should == MerchantObject.new.class
      SalesEngine::Merchant.find_by_name("Johns Inc").class.should == MerchantObject.new.class
      SalesEngine::Merchant.find_by_id("2").class.should == MerchantObject.new.class
    end

    it "returns an instance containing a matching attribute" do
      SalesEngine::Merchant.find_by_created_at("2012-02-26 20:56:50 UTC").respond_to?(:created_at).should == true
      SalesEngine::Merchant.find_by_updated_at("2012-02-26 20:56:50 UTC").respond_to?(:updated_at).should == true
      SalesEngine::Merchant.find_by_name("Johns Inc").respond_to?(:name).should == true
      SalesEngine::Merchant.find_by_id("2").respond_to?(:id).should == true
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

    context "when search results are found" do
      it "returns an array of data" do
        SalesEngine::Merchant.find_all_by_created_at("2012-02-26 20:56:50 UTC").class.should == Array
        SalesEngine::Merchant.find_all_by_updated_at("2012-02-26 20:56:50 UTC").class.should == Array
        SalesEngine::Merchant.find_all_by_name("Johns Inc").class.should == Array
        SalesEngine::Merchant.find_all_by_id("2").class.should == Array
      end

      it "returns instances of the Merchant object" do
        SalesEngine::Merchant.find_all_by_created_at("2012-02-26 20:56:50 UTC").sample.class.should == MerchantObject.new.class
        SalesEngine::Merchant.find_all_by_updated_at("2012-02-26 20:56:50 UTC").sample.class.should == MerchantObject.new.class
        SalesEngine::Merchant.find_all_by_name("Johns Inc").sample.class.should == MerchantObject.new.class
        SalesEngine::Merchant.find_all_by_id("2").sample.class.should == MerchantObject.new.class
      end

      it "returns Merchant objects containing matching attributes" do
        SalesEngine::Merchant.find_all_by_created_at("2012-02-26 20:56:50 UTC").sample.respond_to?(:created_at).should == true
        SalesEngine::Merchant.find_all_by_updated_at("2012-02-26 20:56:50 UTC").sample.respond_to?(:updated_at).should == true
        SalesEngine::Merchant.find_all_by_name("Johns Inc").sample.respond_to?(:name).should == true
        SalesEngine::Merchant.find_all_by_id("2").sample.respond_to?(:id).should == true
      end

    end


    context "when no search results are found" do

      it "returns the empty array" do
        SalesEngine::Merchant.find_all_by_created_at("2012-02-26 20:56:50").should == []
        SalesEngine::Merchant.find_all_by_updated_at("2012-02-26 UTC").should == []
        SalesEngine::Merchant.find_all_by_name("Hot Pies!!").should == []
        SalesEngine::Merchant.find_all_by_id("140").should == []
      end

    end
  end 
end