class RetrieveYoutubeDataJob < ActiveJob::Base

  CHANNEL_ID = 'UCFNSXVFsx1uJ_2fcsQprxWw'.freeze

  def perform(formatted_url)
    data = HTTParty.get(formatted_url)
  end

  private

  def persist(data)
    data[:items].map do |data_item|
      RawVideoData.create(data_item)
    end
  end

end


