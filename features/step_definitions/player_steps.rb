Given(/^I have no songs in my playlist$/) do
# walk through playlist until you reach the end
  click_link_or_button('next') until page.has_content?('No song playing')
end

Given(/^I have "([^"]*)" in my playlist$/) do |song|
  search_for song
  click_link_or_button(:text => 'Add')
end


When(/^I add "([^"]*)" to my playlist$/) do |song|
  search_for song
  click_link_or_button('Add', :text => 'Add')
end

When(/^I wait for (\d+) second$/) do |seconds|
  sleep seconds.to_i
end


Then(/^I should have a song in my playlist$/) do
  click_link_or_button('play')
  within('#playerholder') { should_not have_content('No song playing') }
end

Then(/^the song "([^"]*)" should be the last song in my playlist$/) do |song|
  tmp = find('#currentinfo').text
  last_song = tmp

  until /No song playing/i === tmp do
    last_song = tmp
    click_link_or_button('next')
    tmp = find('#currentinfo').text
  end

  last_song.should == song
end

Then(/^"([^"]*)" should be played$/) do |song_info|
  find(:css, '#currentinfo').text.should match(/#{song_info}/)
end

Then(/^no song should be played$/) do
  find(:css, '#currentinfo').text.should match(/No song playing/)
end
