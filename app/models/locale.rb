# coding: utf-8
class Locale
  LOCALES = {
    'en' => 'English (United States)',
    'es' => 'Español',
    'fr-CA' => 'Français (Canada)',
    'fr-FR' => 'Français (France)',
    'uk' => 'Українська',
    # 'nl' => 'Nederlands',
  }

  class << self
    # @todo Remove once https://github.com/gregbell/active_admin/pull/1470 is merged.
    def available_locales
      LOCALES.keys
    end

    def locale_name(locale)
      LOCALES[locale]
    end

    def locales
      keys = ENV['AVAILABLE_LOCALES'] && ENV['AVAILABLE_LOCALES'].split(',')
      if keys
        LOCALES.slice(*keys)
      else
        LOCALES
      end
    end
  end
end
