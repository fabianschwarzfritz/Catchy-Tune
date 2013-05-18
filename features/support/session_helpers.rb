require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'paths'))

module SessionHelpers
  def sign_up_with(username, password, confirm_password)
    visit path_to 'the sign up page'
    fill_in 'user_username', :with => username
    fill_in 'user_password', :with => password
    fill_in 'user_password_confirmation', :with => confirm_password
    click_button 'Sign up'
  end

  def log_in_with(username, password)
    log_out if logged_in?

    visit path_to 'the login page'
    fill_in 'login_username', :with => username
    fill_in 'login_password', :with => password
    click_button 'Log in'
  end

  def log_out
    visit '/sessions/logout'
  end

  def logged_in?
    visit path_to 'the home page'
    current_path == path_to('the home page')
  end

  def logged_in_user
    if logged_in?
      visit path_to 'the home page'

      /^Home of (.+)$/.match(title)[1]
    else
      nil
    end
  end
end

World(SessionHelpers)