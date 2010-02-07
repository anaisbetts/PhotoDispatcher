class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :relativepath
      t.string :tinythumbnail
      t.string :largethumbnail
      t.string :exif_data_yaml

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
