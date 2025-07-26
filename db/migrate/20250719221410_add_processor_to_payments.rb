class AddProcessorToPayments < ActiveRecord::Migration[8.0]
  def change
    add_column :payments, :processor, :string
    add_index :payments, :processor
  end
end
