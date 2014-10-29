require 'rails_helper'

RSpec.describe Listing, :type => :model do

  it "requires a location" do
    no_loc_listing = Listing.create({
      name: "Test Chair please ignore", 
      description: "good stuff", 
      owner_id: 1, 
      price: 19
    })
    expect(no_loc_listing.errors[:location]).to include("can't be blank")
  end

  it "requires a name" do
    no_name_listing = Listing.create({
      description: "good stuff", 
      location: "somewhere",
      owner_id: 1, 
      price: 19
    })
    expect(no_name_listing.errors[:name]).to include("can't be blank")
  end

  it "requires a price" do
    no_price_listing = Listing.create({
      name: "Test Chair, please ignore",
      description: "good stuff", 
      location: "somewhere",
      owner_id: 1
    })
    expect(no_price_listing.errors[:price]).to include("can't be blank")
  end

  it "creates upon passing validation" do
    complete_listing = Listing.create({
      name: "Test Chair, please ignore",
      description: "good stuff", 
      location: "somewhere",
      owner_id: 1,
      price: 1
    })
    expect(complete_listing.errors.messages).to eq({})
  end

end
