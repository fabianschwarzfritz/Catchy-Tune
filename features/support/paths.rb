module NavigationHelpers
  def path_to(page_name)
    case page_name

      when /the sign\s?up\s?page/i
        '/users/new'
      when /the log\s?in\s?page/i
        '/sessions/login'
      when /the home\s?page/i
        '/sessions/home'

      else
        begin
          page_name =~ /the (.*) page/
          path_components = $1.split(/\s+/)
          self.send(path_components.push('path').join('_').to_sym)
        rescue Object => e
          raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
                    "Now, go and add a mapping in #{__FILE__}"
        end
    end
  end
end

World(NavigationHelpers)