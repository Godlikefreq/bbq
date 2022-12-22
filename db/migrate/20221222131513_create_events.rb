class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :desription
      t.string :address
      t.datetime :datetime

      t.timestamps
    end
  end
end
