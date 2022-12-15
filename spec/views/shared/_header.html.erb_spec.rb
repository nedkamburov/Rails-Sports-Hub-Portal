require "rails_helper"

RSpec.describe 'shared/_header.html.erb', type: :view do
  describe 'without any user logged in' do
    it 'contains the title of the website' do
      render
      expect(rendered).to have_selector("h3>a", text: "Sports Hub")
    end

    it 'contains the search bar' do
      render
      expect(rendered).to have_field("search_term", placeholder: t('home.search_by'))
    end

    it 'contains a functional "Sign up" button' do
      render
      expect(rendered).to have_link(t('devise.general.sign_up'), href: new_user_registration_path)
    end

    it 'contains a functional "Log in" button' do
      render
      expect(rendered).to have_link(t('devise.general.log_in'), href: new_user_session_path)
    end
  end

  describe 'with a logged user' do
    login_user

    it 'contains the name of the user' do
      render
      expect(rendered).to have_selector(".user-details", text: @user.name)
    end

    it 'contains the email of the user' do
      render
      expect(rendered).to have_selector(".user-titles", text: @user.email)
    end

    it 'contains the role of the user' do
      render
      expect(rendered).to have_selector(".user-details", text: @user.role.capitalize)
    end
  end

  describe 'with an admin user' do
    login_admin

    it 'contains the name of the user' do
      render
      expect(rendered).to have_selector(".user-details", text: @admin_user.name)
    end

    it 'contains the email of the user' do
      render
      expect(rendered).to have_selector(".user-titles", text: @admin_user.email)
    end

    it 'contains the role of the user' do
      render
      expect(rendered).to have_selector(".user-details", text: @admin_user.role.capitalize)
    end

    it 'renders the icon to switch to the admin dashboard' do
      render
      expect(rendered).to have_link('', class: 'switch-dashboards', href: admin_root_path)
    end
  end
end