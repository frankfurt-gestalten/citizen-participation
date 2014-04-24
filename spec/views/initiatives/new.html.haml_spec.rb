require 'spec_helper'

describe "initiatives/new" do
  before(:each) do
    assign(:initiative, stub_model(Initiative,
      :title => "MyText",
      :content => "MyText",
      :erreicht => "MyText",
      :getan => "MyText",
      :user_id => 1,
      :lat => "MyString",
      :long => "MyString"
    ).as_new_record)
  end

  it "renders new initiative form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", initiatives_path, "post" do
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
