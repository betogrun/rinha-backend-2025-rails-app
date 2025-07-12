class ChangeMinResponseTimetoIntegerInProcessorStatuses < ActiveRecord::Migration[8.0]
  def change
    change_column :processor_statuses, :min_response_time, :integer, using: 'min_response_time::integer'
  end
end
