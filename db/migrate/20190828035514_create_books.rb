class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string      :title, null:false
      t.string      :author
      t.text        :synopsis
      t.string      :image_url
      t.timestamps
    end
  end
end
