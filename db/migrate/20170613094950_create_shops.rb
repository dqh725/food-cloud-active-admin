class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops, id: :uuid do |t|
      t.string :name, default: '', null: false
      t.string :phone, default: '', null: false
      t.string :address, default: '', null: false
      t.float :latitude, default: 0.0, null: false
      t.float :longitude, default: 0.0, null: false

      t.timestamps null: false
    end
  end
end
