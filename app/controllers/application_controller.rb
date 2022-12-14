class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include Pundit::Authorization
  include DeviseWhitelist
  include Pagy::Backend

  before_action :set_locale

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ?
                    locale : I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
