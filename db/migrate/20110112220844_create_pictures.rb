class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :pictures
  end
end
