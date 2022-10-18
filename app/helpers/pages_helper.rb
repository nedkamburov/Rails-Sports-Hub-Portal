module PagesHelper
  def current_page_title
    panel_items = side_panel_items.insert(1, *sport_pages).insert(-1, *admin_side_panel_items)
    current_page = panel_items.find {|item| current_page? item[:url] }

    current_page ? current_page[:title].html_safe : ''
  end
end
