require 'spec_helper'

describe "blogs/show" do
  before(:each) do
    @blog = assign(:blog, stub_model(Blog,
      :title => "MyText",
      :content => "MyText",
      :user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
  end
end
