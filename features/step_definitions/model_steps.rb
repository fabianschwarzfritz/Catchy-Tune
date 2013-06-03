Given(/^there are these songs:$/) do |table|
  # table is a | song_title    | artist      | (file) |
  #            | Walk the Line | Jonny Cash  | ...    |

  table.hashes.each do |song|
    add_artist song['artist']
    add_track song['song_title'], song['artist'], song['file']
  end
end

Given(/^there are these files:$/) do |table|
  # table is a | file_id | file                 |
  #            | a song  | exampledata/song.mp3 |
  table.hashes.each do |file|
    add_file file['file_id'], file['file']
  end
end
