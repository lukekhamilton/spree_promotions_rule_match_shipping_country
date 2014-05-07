require 'spec_helper'

describe Spree::Promotion::Rules::Country do
  
  context "#eligible?(order)" do
       
    before do 
      state = mock_model(Spree::State, name: "NSW")
      @country = Spree::Country.create!(name: "Australia", iso_name: "Test") 
      @country1 = Spree::Country.create!(name: "New Zealand", iso_name: "Test1") 
      @address = Spree::Address.create!(firstname: "Luke", lastname: "Hamilton", address1: "123 somewhere", city: "Sydney", zipcode: "2000", phone: "0430223558", country_id: @country.id, state: state) 
      @order   = Spree::Order.new(ship_address_id: @address.id) 
          
      @rule = Spree::Promotion::Rules::Country.new 
      @rule.country << @country
      @rule.country << @country1
  
      @order.state = 'address' # Must pass the cart state in the checkout process for this to work
    end

    it "should be eligible if shipping address country matches promotion country" do
      @rule.should be_eligible(@order)
    end

    it "should not eligible if shipping address country doesn't match promotion country" do 
      @order.ship_address = Spree::Address.create 
      @rule.should_not be_eligible(@order)
    end

    it "should not eligible if at the cart state in the checkout process" do 
      @order.state = 'cart'
      @rule.should_not be_eligible(@order)
    end
  end
end
