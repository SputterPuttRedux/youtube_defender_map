class CreateRawVideoDatas < ActiveRecord::Migration
  def change
    create_table :raw_video_datas do |t|
      t.page_info_id :string
      t.derived_video_id :string
      t.etag :string
      t.title :string
      t.description :string
      t.published_date :date
      t.timestamps
    end
  end
end
