require 'spec_helper'

describe "blogs/edit" do
  before(:each) do
    @blog = assign(:blog, stub_model(Blog,
      :title => "MyText",
      :content => "MyText",
      :user_id => 1
    ))
  end

  it "renders the edit blog form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", blog_path(@blog), "post" do
      assert_select "textarea#blog_title[name=?]", "blog[title]"
      assert_select "textarea#blog_content[name=?]", "blog[content]"
      assert_select "input#blog_user_id[name=?]", "blog[user_id]"
    end
  end
end
