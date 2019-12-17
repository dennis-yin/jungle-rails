require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "saves a valid user" do
      @user = User.new(name: "Dennis Yin", email:  "dennis@gmail.com", password: "password", password_confirmation: "password")

      expect(@user).to be_valid
    end

    it "doesn't save when the password and password confirmation don't match" do
      @user = User.new(name: "Dennis Yin", email:  "dennis@gmail.com", password: "password", password_confirmation: "notpassword")

      expect(@user).to_not be_valid
    end

    it "should require a name when saving a user" do
      @user = User.new(name: nil, email:  "dennis@gmail.com", password: "password", password_confirmation: "password")

      expect(@user).to_not be_valid
    end

    it "should require a unique email" do
      @user1 = User.create(name: "Dennis Yin", email:  "dennis@gmail.com", password: "password", password_confirmation: "password")

      @user2 = User.create(name: "Yennis Din", email:  "dennis@gmail.com", password: "password", password_confirmation: "password")

      expect(@user2).to_not be_valid
    end

    it "should require a password that is at least six characters long" do
      @user = User.new(name: "Dennis Yin", email:  "dennis@gmail.com", password: "short", password_confirmation: "short")

      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it "authenticates a valid user" do
      @user = User.create(name: "Dennis Yin", email: "dennis@gmail.com", password: "password", password_confirmation: "password")

      authenticate = @user.authenticate_with_credentials(@user.email, @user.password)

      expect(authenticate).to_not be_nil
    end

    it "doesn't authenticate an invalid user" do
      @user = User.create(name: "Dennis Yin", email: "dennis@gmail.com", password: "password", password_confirmation: "password")

      authenticate = @user.authenticate_with_credentials(@user.email, "wrongpassword")

      expect(authenticate).to be_nil
    end

    it "authenticates a user when they put whitespace around their email" do
      @user = User.create(name: "Dennis Yin", email: "dennis@gmail.com", password: "password", password_confirmation: "password")

      authenticate = @user.authenticate_with_credentials("  dennis@gmail.com  ",@user.password)

      expect(authenticate).to_not be_nil
    end

    it "authenticates a user when they type their email with the wrong case" do
      @user = User.create(name: "Dennis Yin", email: "dennis@gmail.com", password: "password", password_confirmation: "password")

      authenticate= @user.authenticate_with_credentials("dEnNiS@gmail.com", @user.password)

      expect(authenticate).to_not be_nil
    end
  end
end
