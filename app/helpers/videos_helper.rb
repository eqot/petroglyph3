require 'uri'
require 'cgi'

module VideosHelper

  def get_title(video)
    if video && video.title.length > 0
      video.title
    else
      "(no title)"
    end
  end

  def get_thumbnail(video)
    videoId = get_id(video)
    if videoId
      "http://i.ytimg.com/vi/#{videoId}/default.jpg"
    else
      ""
    end
  end

  def get_duration(video)
    duration = video.duration
    if duration
      sec = duration % 60;
      min = (duration / 60).floor % 60;
      hour = (duration / 3600).floor;
      (hour > 0 ? hour.to_s + ':' : '') + (min < 10 ? '0' : '' ) + min.to_s + ':' + (sec < 10 ? '0' : '') + sec.to_s
    else
      ""
    end
  end

  def get_player(video)
    videoId = get_id(video)
    if videoId
      "http://www.youtube.com/embed/#{videoId}?enablejsapi=1"
    else
      ""
    end
  end

  def simple_time(time)
    time.strftime("%b/%d/%y %H:%M")
  end

  private

    def get_id(video)
      uri = URI(video.url)
      if uri.host == "www.youtube.com"
        params = CGI::parse("#{uri.query}")
        params['v'].first
      else
        nil
      end
    end

end
