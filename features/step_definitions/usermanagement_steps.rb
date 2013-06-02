require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'session_helpers'))

Given(/^a user "([^"]*)" with password "([^"]*)"$/) do |_username, _password|
  sign_up_with(_username, _password, _password)
end

Given(/^I am logged in with user "([^"]*)" and password "([^"]*)"$/) do |_username, _password|
  # allow implicit login via registration
  # not necessary to test explicitly, because this step is only called in preparation for other tests
  log_in_with(_username, _password) unless logged_in_user == _username
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

When(/^I log in with user "([^"]*)" and password "([^"]*)"$/) do |_username, _password|
  log_in_with(_username, _password)
end


Then(/^I should be logged in$/) do
  logged_in?.should == true
end

Then(/^I should be logged in as "([^"]*)"$/) do |_username|
  logged_in_user.should == _username
end

Then(/^I should not be logged in$/) do
  visit path_to 'the home page'
  current_path.should_not == path_to('the home page')
end

Then(/^I should see an error message$/) do
  page.has_css?('.text-error', :visible => true)
end

Then(/^I should not see an error message$/) do
  page.has_no_css?('.text-error') or page.has_css?('.text-error', :visible => false)
end
