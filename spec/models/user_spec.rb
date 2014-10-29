require 'rails_helper'

RSpec.describe User, :type => :model do

  it "requires an email" do
    no_email_user = User.create({name: "Test User", password: "password1"})
    expect(no_email_user.errors[:email]).to include("can't be blank")
  end

  it "requires a name" do
    no_name_user = User.create({email: "foo@bar.com", password: "password1"})
    expect(no_name_user.errors[:name]).to include("can't be blank")
  end

  it "requires a password >= 6 characters" do
    small_password_user = User.create( {
      email: "foo@bar.com",
      name: "Test User",
      password: "pass"
      })
    expect(small_password_user.errors[:password][0]).to include("is too short")
  end

  it "creates upon passing validation" do
    complete_user = User.create({
      email: "foo@bar.com",
      name: "Test User",
      password: "password1"
    })
    expect(complete_user.errors.messages).to eq({})
  end

end
