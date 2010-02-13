class AddSettingsYamlToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :settings_yaml, :string
  end

  def self.down
    remove_column :users, :settings_yaml
  end
end
