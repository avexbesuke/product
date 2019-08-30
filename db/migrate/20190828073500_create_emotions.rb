class CreateEmotions < ActiveRecord::Migration[5.2]
  def change
    create_table :emotions do |t|
      t.text       :body, nill: false
      t.string     :images
      t.references :user,foreign_key: true
      t.references :book,foreign_key: true
      t.timestamps
    end
  end
end
