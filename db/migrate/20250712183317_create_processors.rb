class CreateProcessors < ActiveRecord::Migration[8.0]
  def change
    create_table :processors do |t|
      t.string :name, null: false
      t.decimal :fee_rate, precision: 5, scale: 2, null: false

      t.timestamps
    end
  end
end
