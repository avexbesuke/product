class CreateReads < ActiveRecord::Migration[5.2]
  def change
    create_table :reads do |t|

      t.timestamps
    end
  end
end
