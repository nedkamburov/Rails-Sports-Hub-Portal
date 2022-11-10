class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include Pundit::Authorization
  include DeviseWhitelist
  include Pagy::Backend
end
