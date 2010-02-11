class AddImportPathToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :import_path, :string
  end

  def self.down
    remove_column :users, :import_path
  end
end
