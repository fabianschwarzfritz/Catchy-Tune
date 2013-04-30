require 'spec_helper'

describe "tracks/show" do
  before(:each) do
    @track = assign(:track, stub_model(Track,
      :artist_id => "Artist",
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Artist/)
    rendered.should match(/Name/)
  end
end
