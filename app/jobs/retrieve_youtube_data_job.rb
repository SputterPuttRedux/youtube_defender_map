class RetrieveYoutubeDataJob < ActiveJob::Base

  CHANNEL_ID = 'UCFNSXVFsx1uJ_2fcsQprxWw'.freeze

  def perform(formatted_url)
    data = HTTParty.get(formatted_url)
    persist(data)
  end

  private

  def persist(data)
    channel_info = channel_info(data)

    channel_info.raw_video_datas.create(
      raw_video_data(data)
    )
  end

  def raw_video_data(data)
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

  def channel_info(data)
    ChannelInfo.create(
      total_results: data[:pageInfo][:totalResults],
      etag: results[:etag],
      derived_channel_id: data[:items].first[:snippet][:channelId]
    )
  end
end
