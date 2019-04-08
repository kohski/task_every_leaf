class ChangeUserIdColumnOnLabeling < ActiveRecord::Migration[5.2]
  def change
    rename_column :labelings, :user_id, :label_id
  end
end
