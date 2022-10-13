class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include DeviseWhitelist
end
