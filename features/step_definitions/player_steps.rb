Given(/^I have no songs in my playlist$/) do
# walk through playlist until you reach the end
  get('/playlist/next') until
      get('/playlist/current_song.text').body.lstrip.blank?
end

Given(/^I have "([^"]*)" in my playlist$/) do |song_id|
  post('/playlist/add', :songid => song_id)
end


When(/^I add "([^"]*)" to my playlist$/) do |song_id|
  post('/playlist/add', :songid => song_id)
end


Then(/^I should have a song in my playlist$/) do
# accept any answer except only whitespaces
  get('/playlist/current_song.text').body.should_not match(/^\s*$/)
end

Then(/^the song "([^"]*)" should be the last song in my playlist$/) do |song_id|
  song = get('/playlist/current_song.text').body.lstrip
  last_song = song

  until song.blank?
    last_song = song
    get('/playlist/next')
    song = get('/playlist/current_song.text').body.lstrip
  end

  last_song.should == song_id
end

Then(/^a song should be played$/) do
  pending
end
