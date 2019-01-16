class RenameColumnNameToUsers < ActiveRecord::Migration[5.1]
  def up
    remove_column :users, :name
    rename_column :users, :username, :name
  end

  def down
    rename_column :users, :name, :username
    add_column :users, :name, :string, limit: 191
  end
end
