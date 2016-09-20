class VideosController < ActionController::Base
  def show
    @videos = RawVideoData.all
  end
end
