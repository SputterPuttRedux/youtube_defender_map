class VideosController < ActionController::Base
  def show
    @videos = RawVideoData.includes(:channel_info_id)
  end
end
