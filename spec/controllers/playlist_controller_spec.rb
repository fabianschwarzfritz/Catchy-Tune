require 'spec_helper'

describe PlaylistController do

  describe "GET 'stream'" do
    it "returns http success" do
      get 'stream'
      response.should be_success
    end
  end

end
