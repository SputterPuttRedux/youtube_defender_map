class RetrieveYoutubeDataJob < ActiveJob::Base

  CHANNEL_ID = 'UCFNSXVFsx1uJ_2fcsQprxWw'.freeze

  def perform(formatted_url)
    data = HTTParty.get(formatted_url)
  end

  private

  def persist(data)
    data[:items].map do |item|
      RawVideoData.create_with(
        etag: item[:etag],
        title: item[:snippet][:title]
        description: item[:snippet][:description]
        published_date: item[:snippet][:publishedAt]
      ).find_or_create_by(
        derived_video_id: item[:id][:videoId]
      )
    end
  end
end
