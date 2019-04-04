class AddIndexUsersEmail < ActiveRecord::Migration[5.2]
  def c hange
    add_index :users, :email, unique: true
  end
end
