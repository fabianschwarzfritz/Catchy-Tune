Given(/^there are these songs:$/) do |table|
  # table is a | song_title    | artist      |
  #            | Walk the Line | Jonny Cash  |

  table.hashes.each do |song|
    add_artist song['artist']
    add_track song['song_title'], song['artist']
  end
end
