class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.uuid :offer_id
      t.string :image_uid
      t.integer :position

      t.timestamps null: false
    end
  end
end
