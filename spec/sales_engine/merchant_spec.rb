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
    describe "when find_by_ method is called" do
      
      let(:merchantfindby) { SalesEngine::StartupLoader.find_by_(attribute, parameter) }

      context "when case-variant parameters are passed" do 
        [ ["Johns Inc", "johns inc", "JOHNS INC"] ].each do |param|
          it "returns the restuls from a case-insensitive search" do
            SalesEngine::Merchant.find_by_merchant_name(param).should == SalesEngine::Merchant.find_by_merchant_name("Johns Inc")
          end
        end
      end

      it "takes a only valid attributes" do
        #stuff
      end

      it "returns only a single instance" do
        #stuff
      end

      it "returns an instance of the object on which it was called" do
        #stuff
      end

      it "returns an instance containing a matching attribute" do
        #stuff
      end

      it "returns the empty array if no matches are found" do
        #stuff
      end 

    end
  end
end