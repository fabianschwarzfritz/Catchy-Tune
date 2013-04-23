ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  # fixtures :all

  # Add more helper methods to be used by all tests here...
  # Drop all collections after each test case.
  def teardown
    # Automatically remove all collections after testing
    MongoMapper.database.collections.each do |coll|
      MongoMapper.database.collections.each do |coll|
        unless /^system/.match(coll.name)
          coll.remove
        end
      end
    end
  end

# Make sure that each test case has a teardown
# method to clear the db after each test.
  def inherited(base)
    base.define_method :teardown do
      super
    end
  end
end
