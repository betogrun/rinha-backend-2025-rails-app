class RemoveProcessorIdFromPayments < ActiveRecord::Migration[8.0]
  def change
    remove_column :payments, :processor_id, :bigint
  end
end
