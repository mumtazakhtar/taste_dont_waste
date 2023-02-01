class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :ingredients
      t.string :description
      t.integer :cookingTime

      t.timestamps
    end
  end
end
