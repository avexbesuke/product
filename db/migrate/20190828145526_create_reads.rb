class CreateReads < ActiveRecord::Migration[5.2]
  def change
    create_table :reads do |t|
      t.references :user,foreign_key: true
      t.references :book,foreign_key: true
      t.timestamps
    end
  end
end
