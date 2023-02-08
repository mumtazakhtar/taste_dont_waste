class AddColumnToRecipe < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :servings, :integer
    add_column :recipes, :diets, :string
    add_column :recipes, :cuisines, :string
  end
end
