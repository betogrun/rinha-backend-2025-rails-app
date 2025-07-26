class DropProcessorStatuses < ActiveRecord::Migration[8.0]
  def change
    drop_table :processor_statuses do |t|
      t.integer "min_response_time", null: false
      t.boolean "failing_status", default: false, null: false
      t.bigint "processor_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index [ "processor_id" ], name: "index_processor_statuses_on_processor_id"
    end
  end
end
