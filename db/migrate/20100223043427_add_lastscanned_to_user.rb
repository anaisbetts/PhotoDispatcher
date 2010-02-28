class AddLastscannedToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :last_scanned, :timestamp
  end

  def self.down
    remove_column :users, :last_scanned
  end
end
