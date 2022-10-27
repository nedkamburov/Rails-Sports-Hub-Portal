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
    pages = []
    pages << {
      url: @is_admin_panel ? admin_root_path : root_path,
      title: 'Home' }

    static_pages = Category.all
                           .reject { |page| page.category_type == 'articles' }
                           .sort_by{ |page| page.position}
    static_pages.each do |page|
      static_page = {
        url: "pages/#{page.slug}",
        title: page.title
      }
      pages << static_page
    end

    pages
  end

  def admin_side_panel_items
    svg_src_path = 'admin-side-panel/'
    [
      {
        url: '/path-to-be-added',
        title: 'Surveys',
        svg_path: svg_src_path + 'surveys.svg'
      },
      {
        url: '/path-to-be-added',
        title: 'Banners',
        svg_path: svg_src_path + 'banners.svg'
      },
      {
        url: '/path-to-be-added',
        title: 'Languages',
        svg_path: svg_src_path + 'languages.svg'
      },
      {
        url: admin_footer_path,
        title: 'Footer',
        svg_path: svg_src_path + 'footer.svg'
      },
      {
        url: '/path-to-be-added',
        title: 'Social Networks',
        svg_path: svg_src_path + 'social-networks.svg'
      },
      {
        url: '/path-to-be-added',
        title: 'Users',
        svg_path: svg_src_path + 'users.svg'
      },
      {
        url: admin_information_architecture_path,
        title: 'Information Architecture',
        svg_path: svg_src_path + 'ia.svg'
      },
      {
        url: '/path-to-be-added',
        title: 'Teams',
        svg_path: svg_src_path + 'teams.svg'
      },
      {
        url: '/path-to-be-added',
        title: 'News Partners',
        svg_path: svg_src_path + 'news-partners.svg'
      },
      {
        url: '/path-to-be-added',
        title: 'Advertising',
        svg_path: svg_src_path + 'advertising.svg'
      }
    ]
  end

  def sport_pages
    sports = []
    sport_categories = Category.where(category_type: 'articles').sort_by{ |category| category.position}
    sport_categories.each do |sport|
      sport_page = {
        url: "#{@is_admin_panel ? admin_root_path : root_path}/articles/#{sport.slug}",
        title: sport.title
      }
      sports << sport_page
    end

    sports
  end

  def side_panel_helper (style, tag_type, is_admin_page: false)
    panel_links = ''

    panel_items = side_panel_items.insert(1, *sport_pages)
    panel_items.each do |item|
      panel_links << "<#{tag_type}><a href='#{item[:url]}' class='#{style} #{active_item item[:url]}'>#{item[:title]}</a></#{tag_type}>"
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
