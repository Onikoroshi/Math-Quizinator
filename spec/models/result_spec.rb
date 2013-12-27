describe Result do
  it "has a valid factory" do
    FactoryGirl.create(:result).should be_valid
  end
end