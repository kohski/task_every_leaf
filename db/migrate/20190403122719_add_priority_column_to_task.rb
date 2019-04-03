class AddPriorityColumnToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :prioriry, :integer
  end
end
