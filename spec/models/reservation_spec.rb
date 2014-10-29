require 'rails_helper'

RSpec.describe Reservation, :type => :model do

  it "requires a start date" do
    no_start_res = Reservation.create({
      chair_id: 1, 
      end: "2015-04-12T23:20:50.52", 
      sitter_id: 2
    })
    expect(no_start_res.errors[:start]).to include("can't be blank")
  end
  
  it "requires an end date" do
    no_end_res = Reservation.create({
      chair_id: 1, 
      start: "2015-04-12T23:20:50.52", 
      sitter_id: 2
    })
    expect(no_end_res.errors[:end]).to include("can't be blank")
  end
  
  it "sets default status to pending" do
    status_res = Reservation.create({
      chair_id: 1,
      start: "2015-04-12T23:20:50.52",
      end: "2015-05-12T23:20:50.52",
      sitter_id: 2
    })
    expect(status_res.status).to eq("PENDING")
  end

end
