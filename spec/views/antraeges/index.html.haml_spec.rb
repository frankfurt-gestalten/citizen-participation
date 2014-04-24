require 'spec_helper'

describe "antraeges/index" do
  before(:each) do
    assign(:antraeges, [
      stub_model(Antraege,
        :link => "Link",
        :partei => "Partei",
        :nummer => "Nummer",
        :title => "Title",
        :begruendung => "MyText",
        :betreff => "MyText",
        :ergebn => "Ergebn",
        :isse => "MyText",
        :ob_nummer => 1
      ),
      stub_model(Antraege,
        :link => "Link",
        :partei => "Partei",
        :nummer => "Nummer",
        :title => "Title",
        :begruendung => "MyText",
        :betreff => "MyText",
        :ergebn => "Ergebn",
        :isse => "MyText",
        :ob_nummer => 1
      )
    ])
  end

  it "renders a list of antraeges" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Link".to_s, :count => 2
    assert_select "tr>td", :text => "Partei".to_s, :count => 2
    assert_select "tr>td", :text => "Nummer".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Ergebn".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
