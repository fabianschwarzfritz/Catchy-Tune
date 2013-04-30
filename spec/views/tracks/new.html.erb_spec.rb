require 'spec_helper'

describe "tracks/new" do
  before(:each) do
    assign(:track, stub_model(Track,
      :artist_id => "MyString",
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new track form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tracks_path, "post" do
      assert_select "input#track_artist_id[name=?]", "track[artist_id]"
      assert_select "input#track_name[name=?]", "track[name]"
    end
  end
end
