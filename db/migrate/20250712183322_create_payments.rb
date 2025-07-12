class CreatePayments < ActiveRecord::Migration[8.0]
  def change
    create_table :payments do |t|
      t.bigint :amount_cents, null: false
      t.uuid :correlation_id, null: false, index: { unique: true }
      t.references :processor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
