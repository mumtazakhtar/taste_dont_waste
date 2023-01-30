class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :product
      t.date :bestByDate
      t.integer :stock
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
