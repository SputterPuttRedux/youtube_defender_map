class CreateRawVideoDatas < ActiveRecord::Migration
  def change
    create_table :raw_video_datas do |t|
      t.string :page_info_id
      t.string :derived_video_id
      t.string :etag
      t.string :title
      t.string :description
      t.date :published_date
      t.timestamps
    end
  end
end
