module SearchHelper

  def text_with_icon(text, icon, position)
    case position
      when :before
        "<span><i class=\"#{icon}\"></i> #{text}</span>".html_safe
      when :after
        "<span>#{text} <i class=\"#{icon}\"></i></span>".html_safe
    end
  end


  module ArtistExtensions

    def tracks_tmp
      @tracks_tmp ||= Array.new
    end

    def tracks_tmp=(value)
      @tracks_tmp = value
    end
  end

  module TrackExtensions
    def artist_tmp
      @artist_hidden
    end

    def artist_tmp=(value)
      @artist_hidden = value
    end
  end

end
