class AddColumnToUser < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :profile, :text
  end

  def end
    remove_column :users, :profile, :text
  end
end
