module NavigationHelpers
  def path_to(page_name)
    case page_name

      when /root\s?page/i
        '/'
      when /sign\s?up\s?page/i
        '/users/new'
      when /log\s?in\s?page/i
        '/sessions/login'
      when /home\s?page/i
        '/sessions/home'
      when /search\s?result\s?page/i
        '/search/results'
      when /register-?artist-?\s?page/i
        '/artists/new'
      when /new-track\s?page/i
        '/tracks/new'

      else
        begin
          page_name =~ /(.*) page/
          path_components = $1.split(/\s+/)
          self.send(path_components.push('path').join('_').to_sym)
        rescue Object => e
          raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
                    "Now, go and add a mapping in #{__FILE__}"
        end
    end
  end

  def path_pattern_to(page_name)
    case (page_name)
      when /song-?\s?detail[s]?\s?page/i
        /^\/tracks\/\S+$/

      else
        raise "Cant't find mapping from \"#{page_name}\" to a path pattern.\n" +
            "Now, go and add a mappingin #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
