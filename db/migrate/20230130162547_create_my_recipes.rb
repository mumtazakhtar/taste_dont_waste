class CreateMyRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :my_recipes do |t|
      t.string :title
      t.string :ingredients
      t.string :description
      t.integer :cookingTime
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
