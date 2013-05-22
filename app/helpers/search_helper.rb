module SearchHelper

  def text_with_icon(text, icon, position)
    case position
      when :before
        "<span><i class=\"#{icon}\"></i> #{text}</span>".html_safe
      when :after
        "<span>#{text} <i class=\"#{icon}\"></i></span>".html_safe
    end
  end

end
