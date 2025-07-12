class CreateProcessorStatuses < ActiveRecord::Migration[8.0]
  def change
    create_table :processor_statuses do |t|
      t.string :min_response_time, null: false
      t.boolean :failing_status, null: false, default: false
      t.references :processor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
