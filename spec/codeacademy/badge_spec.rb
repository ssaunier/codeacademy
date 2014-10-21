require 'spec_helper'

describe Codeacademy::User do

  describe "#exist" do
    it "should return true if the user does exist" do
      user = Codeacademy::User.new("flros")
      expect(user.exist?).to eq true
    end

    it "should return false if the user does not exist" do
      user = Codeacademy::User.new("goergeabitboldoesnotexist")
      expect(user.exist?).to eq false
    end
  end

  describe "#badges" do
    it "should fetch ruby badges for flros" do
      user = Codeacademy::User.new("flros")
      expect(user.badges).not_to be_empty
    end

    it "should fetch code badges for flros" do
      user = Codeacademy::User.new("flros")
      expect(user.badges("code")).not_to be_empty
    end

    it "should send an empty array for non existent user" do
      user = Codeacademy::User.new("goergeabitboldoesnotexist")
      expect { user.badges } .to raise_error Codeacademy::User::UnknownUserError
    end
  end
end