class DropProcessors < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :payments, :processors
    drop_table :processors do |t|
      t.string "name", null: false
      t.decimal "fee_rate", precision: 5, scale: 2, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
