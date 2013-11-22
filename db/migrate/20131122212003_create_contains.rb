class CreateContains < ActiveRecord::Migration
  def change
    create_table :contains do |t|
      t.integer :video_id
      t.integer :playlist_id

      t.timestamps
    end

    add_index :contains, :video_id
    add_index :contains, :playlist_id
    add_index :contains, [:video_id, :playlist_id], unique: true
  end
end
