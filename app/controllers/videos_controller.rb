class VideosController < ApplicationController
  def show
    @videos = RawVideoData.all.order(published_date: :DESC)
  end
end
