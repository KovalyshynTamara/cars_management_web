module ApplicationHelper
  include Pagy::Frontend

  def locale_switcher
    I18n.available_locales.map do |locale|
      link_to locale_label(locale),
              url_for(locale: locale),
              class: locale_link_classes(locale)
    end.join(" ").html_safe
  end

  private

  def locale_label(locale)
    locale.to_s.upcase
  end

  def locale_link_classes(locale)
    base = "px-2 py-1 rounded transition"

    if I18n.locale == locale
      "#{base} bg-purple-600 text-white"
    else
      "#{base} text-gray-600 hover:text-purple-700"
    end
  end
end
