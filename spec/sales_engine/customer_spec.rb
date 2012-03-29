require 'spec_helper' 

describe SalesEngine::Customer do
  describe ".random" do
    context "when random method called" do
      
      let(:customer) { Fabricate(:customer) }

      it "returns a SalesEngine::Customer" do
        customer
        SalesEngine::Customer.random.should be_a SalesEngine::Customer
      end
    end
  end

  describe ".find_by_" do

    it "takes a only valid attributes" do
      [:id, :first_name, :last_name, :created_at, :updated_at].each do |attribute|
        method = "find_by_#{attribute}".to_sym
        SalesEngine::Customer.should respond_to(method)
      end
    end

    it "returns only a single instance" do
      SalesEngine::Customer.find_by_created_at("2012-02-26 20:56:56 UTC").instance_of?(SalesEngine::Customer).should == true
      SalesEngine::Customer.find_by_updated_at("2012-02-26 20:56:56 UTC").instance_of?(SalesEngine::Customer).should == true
      SalesEngine::Customer.find_by_first_name("Stone").instance_of?(SalesEngine::Customer).should == true
      SalesEngine::Customer.find_by_last_name("Dickens").instance_of?(SalesEngine::Customer).should == true
      SalesEngine::Customer.find_by_id("26").instance_of?(SalesEngine::Customer).should == true
    end

    it "returns an instance of the SalesEngine::Customer object" do
      SalesEngine::Customer.find_by_created_at("2012-02-26 20:56:56 UTC").class.should == SalesEngine::Customer.new.class
      SalesEngine::Customer.find_by_updated_at("2012-02-26 20:56:56 UTC").class.should == SalesEngine::Customer.new.class
      SalesEngine::Customer.find_by_first_name("Stone").class.should == SalesEngine::Customer.new.class
      SalesEngine::Customer.find_by_last_name("Dickens").class.should == SalesEngine::Customer.new.class
      SalesEngine::Customer.find_by_id("26").class.should == SalesEngine::Customer.new.class
    end

    it "returns an instance containing a matching attribute" do
      SalesEngine::Customer.find_by_created_at("2012-02-26 20:56:56 UTC").respond_to?(:created_at).should == true
      SalesEngine::Customer.find_by_updated_at("2012-02-26 20:56:56 UTC").respond_to?(:updated_at).should == true
      SalesEngine::Customer.find_by_first_name("Stone").respond_to?(:first_name).should == true
      SalesEngine::Customer.find_by_last_name("Dickens").respond_to?(:last_name).should == true
      SalesEngine::Customer.find_by_id("26").respond_to?(:id).should == true
    end

    describe "when find_by_first_name method is called" do

      context "when case-variant parameters are passed" do

        ["Stone", "STONE", "stone"].each do |param|
  
          it "returns the results from a case-insensitive search" do
            SalesEngine::Customer.find_by_first_name(param).should == SalesEngine::Customer.find_by_first_name("Stone")
          end
        end
      end

      context "when invalid parameters are passed" do

        ["Jan's Jalopies", "23", ":hippo", ""].each do |param|
          it "returns nil" do
    
            SalesEngine::Customer.find_by_first_name(param).should == nil
          end
        end    
      end

    end

    describe "when find_by_last_name method is called" do

      context "when case-variant parameters are passed" do 

        ["Dickens", "DICKENS", "dickens"].each do |param|
  
          it "returns the results from a case-insensitive search" do
            SalesEngine::Customer.find_by_last_name(param).should == SalesEngine::Customer.find_by_last_name("Dickens")              
          end
        end
      end

      context "when invalid parameters are passed" do

        ["Jan's Jalopies", "23", ":hippo", ""].each do |param|
  
          it "returns nil" do
            SalesEngine::Customer.find_by_last_name(param).should == nil
          end
        end    
      end

    end
    
    describe "when find_by_id method is called" do
      context "when invalid parameters are passed" do
        ["Jan's Jalopies", "1234862", ":hippo", ""].each do |param|
  
          it "returns nil" do
            SalesEngine::Customer.find_by_id(param).should == nil
          end
        end    
      end
    end

  end

  describe ".find_all_by_" do
    
    it "takes a only valid attributes" do
      [:id, :first_name, :last_name, :created_at, :updated_at].each do |attribute|
        method = "find_all_by_#{attribute}".to_sym
        SalesEngine::Customer.should respond_to(method)
      end
    end

    context "when search results are found" do
      it "returns an array of data" do

        SalesEngine::Customer.find_all_by_created_at("2012-02-26 20:56:56 UTC").class.should == Array
        SalesEngine::Customer.find_all_by_updated_at("2012-02-26 20:56:56 UTC").class.should == Array
        SalesEngine::Customer.find_all_by_first_name("Stone").class.should == Array
        SalesEngine::Customer.find_all_by_last_name("Dickens").class.should == Array
        SalesEngine::Customer.find_all_by_id("26").class.should == Array
      end

      it "returns instances of the SalesEngine::Customer object" do

        SalesEngine::Customer.find_all_by_created_at("2012-02-26 20:56:56 UTC").sample.class.should == SalesEngine::Customer.new.class
        SalesEngine::Customer.find_all_by_updated_at("2012-02-26 20:56:56 UTC").sample.class.should == SalesEngine::Customer.new.class
        SalesEngine::Customer.find_all_by_first_name("Stone").sample.class.should == SalesEngine::Customer.new.class
        SalesEngine::Customer.find_all_by_last_name("Dickens").sample.class.should == SalesEngine::Customer.new.class
        SalesEngine::Customer.find_all_by_id("26").sample.class.should == SalesEngine::Customer.new.class
      end

      it "returns SalesEngine::Customer objects containing matching attributes" do

        SalesEngine::Customer.find_all_by_created_at("2012-02-26 20:56:56 UTC").sample.respond_to?(:created_at).should == true
        SalesEngine::Customer.find_all_by_updated_at("2012-02-26 20:56:56 UTC").sample.respond_to?(:updated_at).should == true
        SalesEngine::Customer.find_all_by_first_name("Stone").sample.respond_to?(:first_name).should == true
        SalesEngine::Customer.find_all_by_last_name("Dickens").sample.respond_to?(:last_name).should == true
        SalesEngine::Customer.find_all_by_id("26").sample.respond_to?(:id).should == true
      end

    end

    context "when no search results are found" do

      it "returns the empty array" do

        SalesEngine::Customer.find_all_by_created_at("2012-02-26 20:56:56").should == []
        SalesEngine::Customer.find_all_by_updated_at("2012-02-26 UTC").should == []
        SalesEngine::Customer.find_all_by_first_name("Ziggy").should == []
        SalesEngine::Customer.find_all_by_last_name("Pawp").should == []
        SalesEngine::Customer.find_all_by_id("260812481092").should == []
      end

    end
  end

  describe "#invoices" do

    let(:customer_instance) { Fabricate(:customer) }

    it "does not return nil" do
      merchant_instance.invoices.should_not == nil
    end

    it "does not return the empty array" do
      merchant_instance.invoices.should_not == []
    end

    it "returns a collection of SalesEngine::Item instances" do
      merchant_instance.invoices.sample.class.should == SalesEngine::Invoice.new.class
    end

    it "returns Invoice instances whose Customer ids correspond to the Customer searched" do
      merchant_instance.invoices.sample.send(:customer_id) == merchant_instance.id
    end
  end 
end