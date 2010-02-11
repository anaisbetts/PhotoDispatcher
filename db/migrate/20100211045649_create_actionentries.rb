class CreateActionentries < ActiveRecord::Migration
  def self.up
    create_table :actionentries do |t|
      t.string :action
      t.string :error
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :actionentries
  end
end
