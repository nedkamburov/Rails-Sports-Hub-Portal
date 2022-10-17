module ApplicationHelper

  def login_helper(style = '')
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

  def admin_side_panel_items
    src_path = 'admin-side-panel/'
    [
      {
        url: 'path-to-be-added',
        title: 'Surveys',
        svg_path: src_path + 'surveys.svg'
      },
      {
        url: 'path-to-be-added',
        title: 'Banners',
        svg_path: src_path + 'banners.svg'
      },
      {
        url: 'path-to-be-added',
        title: 'Languages',
        svg_path: src_path + 'languages.svg'
      },
      {
        url: 'path-to-be-added',
        title: 'Footer',
        svg_path: src_path + 'footer.svg'
      },
      {
        url: 'path-to-be-added',
        title: 'Social Networks',
        svg_path: src_path + 'social-networks.svg'
      },
      {
        url: 'path-to-be-added',
        title: 'Users',
        svg_path: src_path + 'users.svg'
      },
      {
        url: 'path-to-be-added',
        title: 'IA',
        svg_path: src_path + 'ia.svg'
      },
      {
        url: 'path-to-be-added',
        title: 'Teams',
        svg_path: src_path + 'teams.svg'
      },
      {
        url: 'path-to-be-added',
        title: 'News Partners',
        svg_path: src_path + 'news-partners.svg'
      },
      {
        url: 'path-to-be-added',
        title: 'Advertising',
        svg_path: src_path + 'advertising.svg'
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

  def side_panel_helper (style, tag_type, is_admin_page: false)
    panel_links = ''

    panel_items = side_panel_items.insert(1, *mock_sports)
    panel_items.each do |item|
      link_url = is_admin_page ? request.path + item[:url] : item[:url]
      panel_links << "<#{tag_type}><a href='#{link_url}' class='#{style} #{active_item link_url}'>#{}</a></#{tag_type}>"
    end

    panel_links.html_safe
  end

  def admin_side_panel_helper (style, tag_type)
      panel_links = ''

      admin_side_panel_items.each do |item|
        panel_links << "<#{tag_type}><a href='#{item[:url]}' class='#{style} #{active_item item[:url]}' title='#{item[:title]}' data-bs-toggle='tooltip' data-bs-placement='right'>
        #{show_svg(item[:svg_path])}
        </a></#{tag_type}>"
      end

      panel_links.html_safe
  end

  def active_item(path)
    "active" if current_page? path
  end

  def current_page_title (is_admin_page: false)
    title = ''
    panel_items = side_panel_items.insert(1, *mock_sports)
    panel_items.each do |item|
      link_url = is_admin_page ? request.path + item[:url] : item[:url]
      title = item[:title] if current_page? link_url
    end
    title.html_safe
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
