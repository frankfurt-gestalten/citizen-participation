require 'spec_helper'

describe "initiatives/edit" do
  before(:each) do
    @initiative = assign(:initiative, stub_model(Initiative,
      :title => "MyText",
      :content => "MyText",
      :erreicht => "MyText",
      :getan => "MyText",
      :user_id => 1,
      :lat => "MyString",
      :long => "MyString"
    ))
  end

  it "renders the edit initiative form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", initiative_path(@initiative), "post" do
      assert_select "textarea#initiative_title[name=?]", "initiative[title]"
      assert_select "textarea#initiative_content[name=?]", "initiative[content]"
      assert_select "textarea#initiative_erreicht[name=?]", "initiative[erreicht]"
      assert_select "textarea#initiative_getan[name=?]", "initiative[getan]"
      assert_select "input#initiative_user_id[name=?]", "initiative[user_id]"
      assert_select "input#initiative_lat[name=?]", "initiative[lat]"
      assert_select "input#initiative_long[name=?]", "initiative[long]"
    end
  end
end
