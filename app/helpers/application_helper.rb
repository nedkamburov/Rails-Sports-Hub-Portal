module ApplicationHelper

  def login_helper style=''
    if current_user.nil?
      (link_to "Sign up", new_user_registration_path, class: style) +
        " ".html_safe +
        (link_to "Log in", new_user_session_path, class: style)
    else
      link_to "Log out", destroy_user_session_path, method: :delete, class: style
    end
  end

  def nav_items
    [
      {
        url: root_path,
        title: 'Home'
      }
    ]
  end

  def nav_helper style, tag_type
    nav_links = ''

    nav_items.each do |item|
      nav_links << "<#{tag_type}><a href='#{item[:url]}' class='#{style} #{active? item[:url]}'>#{item[:title]}</a></#{tag_type}>"
    end

    nav_links.html_safe
  end

  def active? path
    "active" if current_page? path
  end

  def switch_dashboards_helper
    if @is_admin_panel
      alt_message = 'Switch to users view'
      link_path = root_path
    else
      alt_message = 'Switch to admin view'
      link_path = admin_root_path
    end

    link_to show_svg('dashboard-switcher.svg'),
            link_path, class: 'switch-dashboards', title: alt_message if current_user&.admin?
  end

  def show_svg(path)
    File.open("app/assets/images/#{path}", "rb") do |file|
      raw file.read
    end
  end
end
