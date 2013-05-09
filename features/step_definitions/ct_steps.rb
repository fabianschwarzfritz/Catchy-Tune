require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'session_helpers'))

Given(/^a user "([^"]*)" with password "([^"]*)"$/) do |_username, _password|
  sign_up_with(_username, _password, _password)
end

Given(/^I am logged out$/) do
  log_out
end


When(/^I sign up with user "([^"]*)" and password "([^"]*)"$/) do |_username, _password|
  sign_up_with(_username,_password,_password)
end

When(/^I should be logged in$/) do
  visit path_to 'the home page'
  current_path.should == path_to('the home page')
end

When(/^I should be logged in as "([^"]*)"$/) do |_username|
  pending
end

When(/^I should not be logged in$/) do
  pending
end

When(/^I should see an error message$/) do
  pending
end

When(/^user "([^"]*)" is a valid user with the password "([^"]*)"$/) do |_username, _password|
  pending
end

When(/^user "([^"]*)" exists$/) do |_username|
  pending
end

When(/^user "([^"]*)" does not exist$/) do |_username|
  pending
end