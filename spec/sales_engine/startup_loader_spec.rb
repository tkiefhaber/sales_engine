$LOAD_PATH << './'
require 'csv'
require 'spec_helper'
require 'lib/sales_engine/item'
require 'lib/sales_engine/invoice'
require 'lib/sales_engine/invoice_item'
require 'lib/sales_engine/transaction'
require 'lib/sales_engine/merchant'
require 'lib/sales_engine/customer'
require 'lib/sales_engine/startup_loader'

describe SalesEngine::StartupLoader do
  describe "#initialize" do
    context "when initialized with valid data" do

      let(:valid_startup) { SalesEngine::StartupLoader.new("data/merchants.csv", Merchant) }

      it "the loaded_data instance variable is not set to the empty array" do
        valid_startup.loaded_data.should_not == []
      end

      it "the loaded_data instance variable is not set to nil" do
        valid_startup.loaded_data.should_not == nil
      end

      it "the target_class instance variable is set equal to the object passed in as a parameter" do
        valid_startup.target_class.should == Merchant
      end
    end
  end  
end