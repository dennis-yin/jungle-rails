require 'rails_helper'

RSpec.feature "Visitor can add a product to their cart and the cart updates", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Cart updates by one" do
    visit root_path
    first('.product').click_link('Add')

    expect(page).to have_text 'My Cart (1)'
  end

end