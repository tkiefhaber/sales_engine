$LOAD_PATH << './'
require 'csv'
require 'invoice_items_objects'
require 'invoices_objects'
require 'transactions_objects'
require 'item_object'
require 'merchant_object'
require 'customer_object'
require 'spec_helper'
require 'startup_loader'

describe StartupLoader do
  describe "#initialize" do
    context "when initialized" do
      
      it "sets the loaded_data instance variable equal to the empty array" do
        StartupLoader.new("data/merchants.csv", MerchantObject).loaded_data.should == []
      end

      it "receives the class object" do
        StartupLoader.new("data/merchants.csv", MerchantObject)target_class.should == MerchantObject
      end
      
    end
  end  
end