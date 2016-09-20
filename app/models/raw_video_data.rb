class RawVideoData < ActiveRecord::Base
  # has_many :videos
  belongs_to :channel_info
end
