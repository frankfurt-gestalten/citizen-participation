require 'spec_helper'

describe "antraeges/show" do
  before(:each) do
    @antraege = assign(:antraege, stub_model(Antraege,
      :link => "Link",
      :partei => "Partei",
      :nummer => "Nummer",
      :title => "Title",
      :begruendung => "MyText",
      :betreff => "MyText",
      :ergebn => "Ergebn",
      :isse => "MyText",
      :ob_nummer => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Link/)
    rendered.should match(/Partei/)
    rendered.should match(/Nummer/)
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/Ergebn/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
  end
end
