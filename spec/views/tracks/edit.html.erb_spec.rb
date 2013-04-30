require 'spec_helper'

describe "tracks/edit" do
  before(:each) do
    @track = assign(:track, stub_model(Track,
      :artist_id => "MyString",
      :name => "MyString"
    ))
  end

  it "renders the edit track form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", track_path(@track), "post" do
      assert_select "input#track_artist_id[name=?]", "track[artist_id]"
      assert_select "input#track_name[name=?]", "track[name]"
    end
  end
end
