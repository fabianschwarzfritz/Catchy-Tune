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

When(/^I sign up with user "([^"]*)" and password "([^"]*)" and password confirmation "([^"]*)"$/) do |_username, _password, _password_confirmation|
  sign_up_with(_username,_password,_password_confirmation)
end

When(/^I should be logged in$/) do
  visit path_to 'the home page'
  current_path.should == path_to('the home page')
end

When(/^I should be logged in as "([^"]*)"$/) do |_username|
  pending
end

When(/^I should not be logged in$/) do
  visit path_to 'the home page'
  current_path.should_not == path_to('the home page')
end

When(/^I should see an error message$/) do
  page.has_css?('.text-error', :visible => true)
end

When(/^I should not see an error message$/) do
  page.has_no_css?('.text-error') or page.has_css?('.text-error', :visible => false)
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