require 'spec_helper'

describe "tracks/index" do
  before(:each) do
    assign(:tracks, [
      stub_model(Track,
        :artist_id => "Artist",
        :name => "Name"
      ),
      stub_model(Track,
        :artist_id => "Artist",
        :name => "Name"
      )
    ])
  end

  it "renders a list of tracks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Artist".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
