module PagesHelper
  def current_page_title
    panel_items = side_panel_items.insert(1, *sport_pages).insert(-1, *admin_side_panel_items)
    current_page = panel_items.find {|item| current_page? item[:url] }

    current_page ? current_page[:title].html_safe : ''
  end

  def page_path(url)
    root_path + url
  end

  def current_page_in_locale(lang)
    begin
      url_for(locale: lang)
    rescue => e
      root_url(locale: lang)
    end
  end

  def video_duration(video)
    begin
      raw_duration = ActiveStorage::Analyzer::VideoAnalyzer.new(video.video.blob).metadata[:duration]
      Time.at(raw_duration.to_i).utc.strftime("%M:%S") # assumes there won't be videos longer than an hour
    rescue => e
      flash[:notice] = "FFMPEG not installed on the system probably"
    end
  end
end
