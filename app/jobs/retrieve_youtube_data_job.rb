class RetrieveYoutubeDataJob < ActiveJob::Base

  CHANNEL_ID = 'UCFNSXVFsx1uJ_2fcsQprxWw'.freeze

  def perform(formatted_url)
    data = HTTParty.get(formatted_url)
    persist(data)
  end

  private

  def persist(data)
    channel_info(data)

    raw_video_data(data).map do |rvd|
      ChannelInfo.where(etag: data['etag']).first.raw_video_datas \
        .create(rvd)
    end
  end

  def raw_video_data(data)
    data['items'].map do |item|
      rvd = RawVideoData.create_with(
        etag: item['etag'],
        title: item['snippet']['title'],
        description: item['snippet']['description'],
        published_date: item['snippet']['publishedAt']
      ).find_or_create_by(
        derived_video_id: item['id']['videoId']
      )
      # rvd.save ? Rails.logger.info { "Created RawVideoData id: #{rvd.id}" } : Rails.logger.warn { "RawVideoData #{rvd.errors}" }
    end
  end

  def channel_info(data)
    ci = ChannelInfo.create(
      total_results: data['pageInfo']['totalResults'],
      etag: data['etag'],
      derived_channel_id: data['items'].first['snippet']['channelId']
    )

    # ci.save ? Rails.logger.info { "Created ChannelInfo #{ci.id}" } : Rails.logger.warn {"ChannelInfo NOT saved! #{rvd.errors}"}
  end
end
