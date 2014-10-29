require 'rails_helper'

RSpec.describe Message, :type => :model do

  it "requires a receiver" do
    no_rec_msg = Message.create({
      sender_id: 1,
      subject: "it was güd",
      body: "as I said.."
    })
    expect(no_rec_msg.errors[:receiver_id]).to include("can't be blank")
  end

  it "requires a subject" do
    no_subj_msg = Message.create({
      sender_id: 1,
      receiver_id: 2,
      body: "as I said.."
    })
    expect(no_subj_msg.errors[:subject]).to include("can't be blank")
  end
  
  it "does not require a body" do
    no_rec_msg = Message.create({
      sender_id: 1,
      receiver_id: 2,
      subject: "it was güd"
    })
    expect(no_rec_msg.errors.messages).to eq({})
  end

end
