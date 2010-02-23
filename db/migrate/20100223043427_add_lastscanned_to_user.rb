class AddLastscannedToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :last_scanned, :date
  end

  def self.down
    remove_column :users, :last_scanned
  end
end
