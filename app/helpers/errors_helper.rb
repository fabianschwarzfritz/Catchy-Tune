module ErrorsHelper

  def error_messages(object)
    if object.errors.any?
      if object.errors.count <= 1
        "<p class=\"text-error\">#{object.errors.full_messages.first}</p>".html_safe
      else
        "<ul>#{list_error_messages(object)}</ul>".html_safe
      end
    end
  end

  private
  def list_error_messages(object)
    _out = String.new

    object.errors.full_messages.each do |_error_message|
      _out << "<li class=\"text-error\">#{_error_message}</li>"
    end

    _out
  end
end