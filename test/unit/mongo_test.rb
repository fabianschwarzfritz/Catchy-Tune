require 'test_helper'

class MongoTest < ActiveSupport::TestCase

  test "the truth" do
    assert true
  end

  test "be able to write and read connection" do
    conn = Mongo::MongoClient.new
    MongoMapper.connection = conn
    assert_not_nil(MongoMapper.connection)
  end

  test "save a user to the database" do
    user = User.new
    user[:username => "fabian@schwarz-fritz.de"]
    user.save
  end
end