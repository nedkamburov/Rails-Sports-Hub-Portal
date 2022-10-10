module ApplicationHelper

  def login_helper style=''
    if current_user.nil?
      (link_to "Register", new_user_registration_path, class: style) +
        " ".html_safe +
        (link_to "Login", new_user_session_path, class: style)
    else
      link_to "Logout", destroy_user_session_path, method: :delete, class: style
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

    link_to image_tag("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKFH6q9yjjevT9nhCNFI9kFezyq5RtiAd6q9GUhihua50ljFHm1lMZZ_VpXaNoykXfQOs&usqp=CAU", alt: alt_message),
            link_path, class: 'switch-dashboards', title: alt_message if current_user&.admin?
  end
end
