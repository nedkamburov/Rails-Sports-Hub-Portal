module PagesHelper
  def current_page_title (is_admin_page: false)
    title = ''
    panel_items = side_panel_items.insert(1, *mock_sports).insert(-1, *admin_side_panel_items)
    panel_items.each do |item|
      link_url = is_admin_page ? request.path + item[:url] : item[:url]
      title = item[:title] if current_page? link_url
    end
    title.html_safe
  end
end
