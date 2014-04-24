require 'spec_helper'

describe "initiatives/show" do
  before(:each) do
    @initiative = assign(:initiative, stub_model(Initiative,
      :title => "MyText",
      :content => "MyText",
      :erreicht => "MyText",
      :getan => "MyText",
      :user_id => 1,
      :lat => "Lat",
      :long => "Long"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/Lat/)
    rendered.should match(/Long/)
  end
end
