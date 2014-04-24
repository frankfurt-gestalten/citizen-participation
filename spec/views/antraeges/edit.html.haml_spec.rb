require 'spec_helper'

describe "antraeges/edit" do
  before(:each) do
    @antraege = assign(:antraege, stub_model(Antraege,
      :link => "MyString",
      :partei => "MyString",
      :nummer => "MyString",
      :title => "MyString",
      :begruendung => "MyText",
      :betreff => "MyText",
      :ergebn => "MyString",
      :isse => "MyText",
      :ob_nummer => 1
    ))
  end

  it "renders the edit antraege form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", antraege_path(@antraege), "post" do
      assert_select "input#antraege_link[name=?]", "antraege[link]"
      assert_select "input#antraege_partei[name=?]", "antraege[partei]"
      assert_select "input#antraege_nummer[name=?]", "antraege[nummer]"
      assert_select "input#antraege_title[name=?]", "antraege[title]"
      assert_select "textarea#antraege_begruendung[name=?]", "antraege[begruendung]"
      assert_select "textarea#antraege_betreff[name=?]", "antraege[betreff]"
      assert_select "input#antraege_ergebn[name=?]", "antraege[ergebn]"
      assert_select "textarea#antraege_isse[name=?]", "antraege[isse]"
      assert_select "input#antraege_ob_nummer[name=?]", "antraege[ob_nummer]"
    end
  end
end
