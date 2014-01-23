describe List do

  before(:each) do
    # set up a hash of attributes to use to initialize a valid list instance
        # set up a hash of attributes to use to initialize a valid social coupon instance
    @valid_attributes = {
    }
    l = List.new(@valid_attributes)
  end

  after(:each) do
    # this will be run once after each example
    l.destroy unless l.new_record?
  end

  it "is valid with valid attributes" do
    l.errors.should be_empty
    l.save
    l.errors.should be_empty
    l.should be_valid
  end

  it "" do

  end

  it "" do

  end

  it "" do

  end

  it "" do

  end

  it "" do

  end

end