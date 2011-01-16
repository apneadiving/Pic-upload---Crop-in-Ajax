class ChangePicture < ActiveRecord::Migration
  def self.up
    remove_column :pictures, :user_id
    add_column :pictures, :profile_id, :integer
  end

  def self.down
    remove_column :pictures, :profile_id
    add_column :pictures, :user_id, :integer
  end
end