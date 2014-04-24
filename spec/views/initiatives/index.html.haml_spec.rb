require 'spec_helper'

describe "initiatives/index" do
  before(:each) do
    assign(:initiatives, [
      stub_model(Initiative,
        :title => "MyText",
        :content => "MyText",
        :erreicht => "MyText",
        :getan => "MyText",
        :user_id => 1,
        :lat => "Lat",
        :long => "Long"
      ),
      stub_model(Initiative,
        :title => "MyText",
        :content => "MyText",
        :erreicht => "MyText",
        :getan => "MyText",
        :user_id => 1,
        :lat => "Lat",
        :long => "Long"
      )
    ])
  end

  it "renders a list of initiatives" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Lat".to_s, :count => 2
    assert_select "tr>td", :text => "Long".to_s, :count => 2
  end
end
