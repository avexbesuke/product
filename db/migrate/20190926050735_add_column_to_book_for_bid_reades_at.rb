class AddColumnToBookForBidReadesAt < ActiveRecord::Migration[5.2]
  def up
    add_column :books, :bid, :string
    add_column :books, :readed_at, :datetime
  end

  def down
    remove_column :books, :bid, :string
    remove_column :books, :readed_at, :datetime
  end
end
