require 'spec_helper'

describe User do

  before(:each) do
   User.new(@valid_attributes)
  end


  it "is valid with valid attributes" do
    u.errors.should be_empty
    u.default_list = Factory.build(:list, :list_name => 'LikeList')
    u.save
    u.errors.should be_empty
    u.should be_valid
  end

  it "is valid without explicitly creating a default list" do
    u.save
    u.errors.should be_empty
    u.should be_valid
  end

  it "is not valid without last name" do
    u.last_name = nil
    u.save
    u.errors.should_not be_empty
    u.should_not be_valid
  end


end