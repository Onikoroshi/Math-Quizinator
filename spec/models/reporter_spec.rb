describe Reporter do
  it "has a valid factory" do
    FactoryGirl.create(:reporter).should be_valid
  end
end