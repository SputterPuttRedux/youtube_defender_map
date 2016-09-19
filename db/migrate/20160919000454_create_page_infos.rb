class CreatePageInfos < ActiveRecord::Migration
  def change
    create_table :page_infos do |t|
      t.integer :total_results
      t.string :etag
      t.string :derived_channel_id
      t.timestamps
    end
  end
end
