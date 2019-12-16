require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.new(:name => "Toys")
    end

    it "saves a valid product" do
      @product = Product.new(:name => "Transformer", :price => 10, :quantity => 50, :category => @category)

      expect(@product).to be_valid
    end

    it "fails to save a product if its name is missing" do
      @product = Product.new(:name => nil, :price => 10, :quantity => 50, :category => @category)

      expect(@product).to_not be_valid
    end

    it "fails to save a product if its price is missing" do
      @product = Product.new(:name => "Transformer", :price => nil, :quantity => 50, :category => @category)

      expect(@product).to_not be_valid
    end

    it "fails to save a product if its quantity is missing" do
      @product = Product.new(:name => "Transformer", :price => nil, :quantity => nil, :category => @category)

      expect(@product).to_not be_valid
    end

    it "fails to save a product if its category is missing" do
      @product = Product.new(:name => "Transformer", :price => nil, :quantity => 50, :category => nil)

      expect(@product).to_not be_valid
    end
  end
end