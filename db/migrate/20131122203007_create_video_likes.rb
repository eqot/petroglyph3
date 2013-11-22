class CreateVideoLikes < ActiveRecord::Migration
  def change
    create_table :video_likes do |t|
      t.integer :user_id
      t.integer :video_id

      t.timestamps
    end
    add_index :video_likes, :user_id
    add_index :video_likes, :video_id
    add_index :video_likes, [:user_id, :video_id], unique: true
  end
end
