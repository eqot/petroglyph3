class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :title
      t.text :description
      t.integer :user_id

      t.timestamps
    end

    add_index :playlists, [:user_id, :created_at]
  end
end
