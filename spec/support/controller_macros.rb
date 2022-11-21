module ControllerMacros
  def login_user
    # Before each test, create and login the user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryBot.create(:user)
      # user.confirm! # Or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in @user
    end
  end

  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      @admin_user = FactoryBot.create(:admin_user)
      sign_in @admin_user
    end
  end
end