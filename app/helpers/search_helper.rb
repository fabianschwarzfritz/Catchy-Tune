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

    def tracks_prefetched
      @tracks_prefetched ||= Array.new
    end

    def tracks_prefetched=(value)
      @tracks_prefetched = value
    end
  end

  module TrackExtensions
    def artist_prefetched
      @artist_prefetched
    end

    def artist_prefetched=(value)
      @artist_prefetched = value
    end
  end

end
