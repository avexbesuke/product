class AddColumnToMapForBookUserMemori < ActiveRecord::Migration[5.2]
  def up
    add_column :maps, :memori, :text
    add_reference :maps, :user, null: false, foreign_key: true
    add_reference :maps, :user, null: false, foreign_key: true
  end

  def down
    remove_column :maps, :memori, :text
    remove_reference :maps, :user, null: false, foreign_key: true
    remove_reference :maps, :user, null: false, foreign_key: true
  end
end
