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

  def side_panel_items
    [
      {
        url: root_path,
        title: 'Home'
      },
      {
        url: 'path-to-be-added',
        title: 'Team hub'
      },
      {
        url: 'path-to-be-added',
        title: 'Lifestyle'
      },
      {
        url: 'path-to-be-added',
        title: 'Dealbook'
      },
      {
        url: 'path-to-be-added',
        title: 'Video'
      }
    ]
  end

  # Todo: replace this mock with actual Sports when they are added
  def mock_sports
    [
      {
        url: 'path-to-be-added',
        title: 'NBA'
      },
      {
        url: 'path-to-be-added',
        title: 'NFL'
      },
      {
        url: 'path-to-be-added',
        title: 'NASCAR'
      }
    ]
  end

  def side_panel_helper style, tag_type
    panel_links = ''

    panel_items = side_panel_items.insert(1, *mock_sports)
    panel_items.each do |item|
      panel_links << "<#{tag_type}><a href='#{item[:url]}' class='#{style} #{active? item[:url]}'>#{item[:title]}</a></#{tag_type}>"
    end

    panel_links.html_safe
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
