class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers, id: :uuid do |t|
      t.string :name, default: '', null: false
      t.string :description, default: '', null: false
      t.float :original_value, default: 0.0, null: false
      t.float :current_value, default: 0.0, null: false
      t.uuid :shop_id, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false

      t.timestamps null: false
    end
  end
end
